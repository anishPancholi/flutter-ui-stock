import 'package:attendance_management/models/entities/attendance_register.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_dss/digit_dss.dart';
import 'package:digit_scanner/blocs/scanner.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/theme/digit_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:location/location.dart';

import 'blocs/app_initialization/app_initialization.dart';
import 'blocs/auth/auth.dart';
import 'blocs/localization/localization.dart';
import 'blocs/project/project.dart';
import 'blocs/stock_bloc.dart';
import 'data/local_store/app_shared_preferences.dart';
import 'data/network_manager.dart';
import 'data/remote_client.dart';
import 'data/repositories/remote/bandwidth_check.dart';
import 'data/repositories/remote/localization.dart';
import 'data/repositories/remote/mdms.dart';
import 'data/repositories/remote/stock.dart';
import 'router/app_navigator_observer.dart';
import 'router/app_router.dart';
import 'utils/environment_config.dart';
import 'utils/localization_delegates.dart';
import 'utils/utils.dart';
import 'widgets/network_manager_provider_wrapper.dart';

class MainApplication extends StatefulWidget {
  final Dio client;
  final AppRouter appRouter;
  final Isar isar;
  final LocalSqlDataStore sql;

  const MainApplication({
    super.key,
    required this.isar,
    required this.client,
    required this.appRouter,
    required this.sql,
  });

  @override
  State<StatefulWidget> createState() {
    return MainApplicationState();
  }
}

class MainApplicationState extends State<MainApplication>
    with WidgetsBindingObserver {
  @override
  void initState() {
    LocalizationParams().setModule('boundary', true);
    super.initState();
    requestDisableBatteryOptimization();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalSqlDataStore>.value(value: widget.sql),
        RepositoryProvider<Isar>.value(value: widget.isar),
      ],
      child: BlocProvider(
        create: (context) => AppInitializationBloc(
          isar: widget.isar,
          mdmsRepository: MdmsRepository(widget.client),
          dashboardRemoteRepository: DashboardRemoteRepository(widget.client),
        )..add(const AppInitializationSetupEvent()),
        child: NetworkManagerProviderWrapper(
          isar: widget.isar,
          configuration: const NetworkManagerConfiguration(
            persistenceConfig: PersistenceConfiguration.offlineFirst,
          ),
          dio: widget.client,
          sql: widget.sql,
          child: MultiBlocProvider(
            providers: [
              // INFO : Need to add bloc of package Here
              BlocProvider(
                create: (_) {
                  return LocationBloc(location: Location())
                    ..add(const LoadLocationEvent());
                },
                lazy: false,
              ),
              BlocProvider(
                create: (_) {
                  return DigitScannerBloc(
                    const DigitScannerState(),
                  );
                },
                lazy: false,
              ),
              BlocProvider(
                create: (context) {
                  return UserBloc(
                    const UserEmptyState(),
                    userRemoteRepository: context
                        .read<RemoteRepository<UserModel, UserSearchModel>>(),
                  );
                },
              ),
              BlocProvider(
                create: (ctx) => AuthBloc(
                  authRepository: ctx.read(),
                  mdmsRepository: MdmsRepository(widget.client),
                  individualRemoteRepository: ctx.read<
                      RemoteRepository<IndividualModel,
                          IndividualSearchModel>>(),
                )..add(
                    AuthAutoLoginEvent(
                      tenantId: envConfig.variables.tenantId,
                    ),
                  ),
              ),
              BlocProvider(
                create: (ctx) => BoundaryBloc(
                  const BoundaryState(),
                  boundaryRepository: ctx
                      .read<NetworkManager>()
                      .repository<BoundaryModel, BoundarySearchModel>(ctx),
                ),
              ),
            ],
            child: BlocBuilder<AppInitializationBloc, AppInitializationState>(
              builder: (context, appConfigState) {
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (appConfigState is! AppInitialized) {
                      return const MaterialApp(
                        home: Scaffold(
                          body: Center(
                            child: Text('Loading'),
                          ),
                        ),
                      );
                    }

                    final appConfig = appConfigState.appConfiguration;

                    final localizationModulesList = appConfig.backendInterface;
                    var firstLanguage;
                    firstLanguage = appConfig.languages?.lastOrNull?.value;
                    final selectedLocale =
                        AppSharedPreferences().getSelectedLocale ??
                            firstLanguage;
                    LocalizationParams().setLocale(Locale(selectedLocale));
                    final languages = appConfig.languages;

                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (localizationModulesList != null &&
                                  firstLanguage != null)
                              ? (context) => LocalizationBloc(
                                  const LocalizationState(),
                                  LocalizationRepository(
                                      widget.client, widget.sql),
                                  widget.sql)
                                ..add(
                                  LocalizationEvent.onLoadLocalization(
                                    module:
                                        "hcm-boundary-${envConfig.variables.hierarchyType.toLowerCase()},${localizationModulesList.interfaces.where((element) => element.type == Modules.localizationModule).map((e) => e.name.toString()).join(',')}",
                                    tenantId: appConfig.tenantId.toString(),
                                    locale: firstLanguage,
                                    path: Constants.localizationApiPath,
                                  ),
                                )
                              : (context) => LocalizationBloc(
                                  const LocalizationState(),
                                  LocalizationRepository(
                                      widget.client, widget.sql),
                                  widget.sql),
                        ),
                        BlocProvider(
                          create: (ctx) => ProjectBloc(
                            bandwidthCheckRepository: BandwidthCheckRepository(
                              DioClient().dio,
                              bandwidthPath:
                                  envConfig.variables.checkBandwidthApiPath,
                            ),
                            mdmsRepository: MdmsRepository(widget.client),
                            dashboardRemoteRepository:
                                DashboardRemoteRepository(widget.client),
                            facilityLocalRepository: ctx.read<
                                LocalRepository<FacilityModel,
                                    FacilitySearchModel>>(),
                            facilityRemoteRepository: ctx.read<
                                RemoteRepository<FacilityModel,
                                    FacilitySearchModel>>(),
                            projectFacilityLocalRepository: ctx.read<
                                LocalRepository<ProjectFacilityModel,
                                    ProjectFacilitySearchModel>>(),
                            projectFacilityRemoteRepository: ctx.read<
                                RemoteRepository<ProjectFacilityModel,
                                    ProjectFacilitySearchModel>>(),
                            projectLocalRepository: ctx.read<
                                LocalRepository<ProjectModel,
                                    ProjectSearchModel>>(),
                            projectStaffLocalRepository: ctx.read<
                                LocalRepository<ProjectStaffModel,
                                    ProjectStaffSearchModel>>(),
                            projectStaffRemoteRepository: ctx.read<
                                RemoteRepository<ProjectStaffModel,
                                    ProjectStaffSearchModel>>(),
                            projectRemoteRepository: ctx.read<
                                RemoteRepository<ProjectModel,
                                    ProjectSearchModel>>(),
                            isar: widget.isar,
                            boundaryRemoteRepository: ctx.read<
                                RemoteRepository<BoundaryModel,
                                    BoundarySearchModel>>(),
                            boundaryLocalRepository: ctx.read<
                                LocalRepository<BoundaryModel,
                                    BoundarySearchModel>>(),
                            productVariantLocalRepository: ctx.read<
                                LocalRepository<ProductVariantModel,
                                    ProductVariantSearchModel>>(),
                            productVariantRemoteRepository: ctx.read<
                                RemoteRepository<ProductVariantModel,
                                    ProductVariantSearchModel>>(),
                            projectResourceLocalRepository: ctx.read<
                                LocalRepository<ProjectResourceModel,
                                    ProjectResourceSearchModel>>(),
                            projectResourceRemoteRepository: ctx.read<
                                RemoteRepository<ProjectResourceModel,
                                    ProjectResourceSearchModel>>(),
                            individualLocalRepository: ctx.read<
                                LocalRepository<IndividualModel,
                                    IndividualSearchModel>>(),
                            individualRemoteRepository: ctx.read<
                                RemoteRepository<IndividualModel,
                                    IndividualSearchModel>>(),
                            context: context,
                          ),
                        ),
                        BlocProvider(
                            create: (ctx) => DashboardBloc(
                                  const DashboardState.initialState(),
                                  isar: widget.isar,
                                  dashboardRemoteRepo:
                                      DashboardRemoteRepository(widget.client),
                                  attendanceDataRepository: context.repository<
                                      AttendanceRegisterModel,
                                      AttendanceRegisterSearchModel>(),
                                  individualDataRepository: context.repository<
                                      IndividualModel, IndividualSearchModel>(),
                                )),
                        BlocProvider(
                          create: (context) => FacilityBloc(
                            facilityDataRepository: context.repository<
                                FacilityModel, FacilitySearchModel>(),
                            projectFacilityDataRepository: context.repository<
                                ProjectFacilityModel,
                                ProjectFacilitySearchModel>(),
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ProductVariantBloc(
                            const ProductVariantEmptyState(),
                            context.repository<ProductVariantModel,
                                ProductVariantSearchModel>(),
                            context.repository<ProjectResourceModel,
                                ProjectResourceSearchModel>(),
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ProjectFacilityBloc(
                            const ProjectFacilityState.loading(),
                            projectFacilityDataRepository: context.repository<
                                ProjectFacilityModel,
                                ProjectFacilitySearchModel>(),
                          ),
                        ),
                        BlocProvider<StockBloc>(
                          create: (context) => StockBloc(
                            StockRepository(widget.client),
                          ),
                        ),
                      ],
                      child: BlocBuilder<LocalizationBloc, LocalizationState>(
                        builder: (context, langState) {
                          final selectedLocale =
                              AppSharedPreferences().getSelectedLocale ??
                                  firstLanguage;

                          return MaterialApp.router(
                            debugShowCheckedModeBanner: false,
                            builder: (context, child) {
                              final env = envConfig.variables.envType;
                              if (env == EnvType.prod) {
                                return child ?? const SizedBox.shrink();
                              }

                              return Banner(
                                message: envConfig.variables.envType.name,
                                location: BannerLocation.topEnd,
                                color: () {
                                  switch (envConfig.variables.envType) {
                                    case EnvType.uat:
                                      return Colors.green;
                                    case EnvType.qa:
                                      return Colors.pink;
                                    default:
                                      return Colors.red;
                                  }
                                }(),
                                child: child,
                              );
                            },
                            supportedLocales: languages != null
                                ? languages.map((e) {
                                    final results = e.value.split('_');

                                    return results.isNotEmpty
                                        ? Locale(results.first, results.last)
                                        : firstLanguage;
                                  })
                                : [firstLanguage],
                            localizationsDelegates: getAppLocalizationDelegates(
                              sql: widget.sql,
                              appConfig: appConfig,
                              selectedLocale: Locale(
                                selectedLocale!.split("_").first,
                                selectedLocale.split("_").last,
                              ),
                            ),
                            locale: languages != null
                                ? Locale(
                                    selectedLocale!.split("_").first,
                                    selectedLocale.split("_").last,
                                  )
                                : firstLanguage,
                            theme: DigitTheme.instance.mobileTheme,
                            routeInformationParser:
                                widget.appRouter.defaultRouteParser(),
                            scaffoldMessengerKey: scaffoldMessengerKey,
                            routerDelegate: AutoRouterDelegate.declarative(
                              widget.appRouter,
                              navigatorObservers: () => [AppRouterObserver()],
                              routes: (handler) => authState.maybeWhen(
                                orElse: () => [
                                  const UnauthenticatedRouteWrapper(),
                                ],
                                authenticated: (_, __, ___, ____, _____) => [
                                  AuthenticatedRouteWrapper(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
