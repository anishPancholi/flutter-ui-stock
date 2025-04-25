// First, let's create the Warehouse Details page
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/blocs/product_variant.dart'
    as inventoryManagement;
// import 'package:inventory_management/blocs/product_variant.dart';
// import 'package:inventory_management/utils/extensions/extensions.dart'
//     as inventoryExt;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';

import '../utils/extensions/extensions.dart';

// Import your models, blocs, and utilities.
import 'package:digit_data_model/data_model.dart'; // for StockModel, etc.
import '../router/app_router.dart';

import 'package:digit_data_model/utils/utils.dart';

import '../blocs/localization/app_localization.dart';
import '../blocs/stock_bloc.dart';
// We don't need to import facility_bloc.dart since it's provided globally
// import '../blocs/facility/facility_state.dart';
import '../models/entities/stock.dart';
import '../utils/environment_config.dart';
import '../utils/typedefs.dart';

class WarehouseDetailsPage extends StatefulWidget {
  final StockModel? model;

  const WarehouseDetailsPage({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  _WarehouseDetailsPageState createState() => _WarehouseDetailsPageState();
}

class _WarehouseDetailsPageState extends State<WarehouseDetailsPage> {
  // Define form keys
  static const String _dateKey = 'date';
  static const String _adminUnitKey = 'adminUnit';
  static const String _facilityKey = 'facility';
  // static const String _teamCodeKey = 'teamCode';

  // Facility data
  String? selectedFacilityId;
  final TextEditingController _facilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize selected facility from model (if available)
    selectedFacilityId = widget.model?.facilityId;
    if (selectedFacilityId != null) {
      Future.delayed(Duration.zero, () {
        _facilityController.text =
            AppLocalizations.of(context).translate('FAC_$selectedFacilityId');
      });
    }
  }

  @override
  void dispose() {
    _facilityController.dispose();
    super.dispose();
  }

  // Build the Reactive Form Group
  FormGroup buildForm() {
    return fb.group(<String, Object>{
      _dateKey: FormControl<DateTime>(value: DateTime.now()),
      _adminUnitKey: FormControl<String>(
          value: context.boundary.code, validators: [Validators.required]),
      _facilityKey: FormControl<String>(
          value: selectedFacilityId ?? "", validators: [Validators.required]),
      // _teamCodeKey: FormControl<String>(validators: [Validators.required]),
    });
  }

  void _navigateToReceivedStockDetails(FormGroup formGroup) {
    // Mark all controls as touched to trigger validation
    formGroup.markAllAsTouched();
    if (!formGroup.valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)
              .translate('Please fill all required fields (marked with *)')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Prepare data to pass to next page
    final data = {
      'date': formGroup.control(_dateKey).value as DateTime,
      'adminUnit': formGroup.control(_adminUnitKey).value as String,
      'facilityId': formGroup.control(_facilityKey).value as String,
      // 'teamCode': formGroup.control(_teamCodeKey).value as String,
    };

    // Navigate to Received Stock Details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceivedStockDetailsPage(warehouseData: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocProvider<FacilityBloc>(
      create: (context) => FacilityBloc(
          facilityDataRepository:
              context.repository<FacilityModel, FacilitySearchModel>(),
          projectFacilityDataRepository: context
              .repository<ProjectFacilityModel, ProjectFacilitySearchModel>())
        ..add(
            FacilityLoadForProjectEvent(projectId: context.selectedProject.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.translate('Warehouse Details')),
        ),
        body: ReactiveFormBuilder(
          form: () => buildForm(),
          builder: (BuildContext context, FormGroup formGroup, Widget? child) {
            return ScrollableContent(
              enableFixedDigitButton: true,
              footer: DigitCard(
                margin: const EdgeInsets.all(16),
                children: [
                  DigitButton(
                    label: localizations.translate("Next"),
                    type: DigitButtonType.primary,
                    size: DigitButtonSize.large,
                    mainAxisSize: MainAxisSize.max,
                    onPressed: () => _navigateToReceivedStockDetails(formGroup),
                  ),
                ],
              ),
              children: [
                DigitCard(
                  margin: const EdgeInsets.all(16),
                  children: [
                    // Date of receipt field
                    ReactiveWrapperField(
                        formControlName: _dateKey,
                        builder: (field) {
                          return InputField(
                            type: InputType.date,
                            label: localizations.translate('Date of receipt'),
                            confirmText: localizations.translate('Confirm'),
                            cancelText: localizations.translate('Cancel'),
                            initialValue: DateFormat('dd/MM/yy')
                                .format(field.control.value),
                            readOnly: true,
                          );
                        }),
                    const SizedBox(height: 15),

                    // Administrative unit field
                    ReactiveWrapperField(
                      formControlName: _adminUnitKey,
                      validationMessages: {
                        'required': (_) => localizations
                            .translate("Administrative unit is required"),
                      },
                      builder: (field) => LabeledField(
                        label: localizations.translate("Administrative unit"),
                        isRequired: true,
                        child: DigitTextFormInput(
                          isDisabled: true,
                          initialValue: context.boundary.code,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    const SizedBox(height: 15),

                    // Facility selector
                    BlocBuilder<FacilityBloc, FacilityState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const Offstage(),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          fetched: (facilities, allFacilities) {
                            return ReactiveWrapperField(
                              formControlName: _facilityKey,
                              builder: (field) => LabeledField(
                                label:
                                    localizations.translate('Select Facility'),
                                capitalizedFirstLetter: false,
                                isRequired: true,
                                child: DigitDropdown<FacilityModel>(
                                  items: facilities
                                      .map((f) => DropdownItem(
                                          name: 'PF_${f.id}', code: f.id))
                                      .toList(),
                                  onSelect: (value) {
                                    formGroup.control(_facilityKey).value =
                                        value.code;
                                  },
                                  emptyItemText:
                                      localizations.translate('No match found'),
                                  errorMessage:
                                      formGroup.control(_facilityKey).hasErrors
                                          ? localizations.translate(
                                              'Field is required',
                                            )
                                          : null,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Second page - Received Stock Details
class ReceivedStockDetailsPage extends StatefulWidget {
  final Map<String, dynamic> warehouseData;

  const ReceivedStockDetailsPage({
    Key? key,
    required this.warehouseData,
  }) : super(key: key);

  @override
  _ReceivedStockDetailsPageState createState() =>
      _ReceivedStockDetailsPageState();
}

class _ReceivedStockDetailsPageState extends State<ReceivedStockDetailsPage> {
  // Define form keys
  static const String _productKey = 'product';
  static const String _receivedFromKey = 'receivedFrom';
  static const String _quantityKey = 'quantity';
  static const String _commentsKey = 'comments';

  //   String? selectedProductId;
  //     final TextEditingController _productController = TextEditingController();

  //       @override
  // void initState() {
  //   super.initState();
  //   // Initialize selected facility from model (if available)
  //   selectedProductId = widget.model?.ProductId;
  //   if (selectedProductId != null) {
  //     Future.delayed(Duration.zero, () {
  //       _productController.text =
  //           AppLocalizations.of(context).translate('FAC_$selectedProductId');
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   _productController.dispose();
  //   super.dispose();
  // }

  // Build the Reactive Form Group
  FormGroup buildForm() {
    return fb.group(<String, Object>{
      _productKey: FormControl<String>(validators: [Validators.required]),
      _receivedFromKey: FormControl<String>(validators: [Validators.required]),
      _quantityKey: FormControl<int>(validators: [Validators.required]),
      _commentsKey: FormControl<String>(),
    });
  }

  void _submitForm(FormGroup formGroup) {
    // Mark all controls as touched to trigger validation
    formGroup.markAllAsTouched();
    if (!formGroup.valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)
              .translate('Please fill all required fields (marked with *)')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String tenantId = envConfig.variables.tenantId;
    final String clientReferenceId = IdGen.i.identifier;

    // Extract data from both forms
    final facilityId =
        widget.warehouseData['facilityId'] as String; // Not used in model
    final productId = formGroup.control(_productKey).value as String;
    final receiverId = formGroup.control(_receivedFromKey).value as String;
    // final receiverId = widget.warehouseData[_receivedFromKey] as String;
    // final senderId = formGroup.control(facilityId).value as String;
    final quantity = formGroup.control(_quantityKey).value as int;
    final comments = formGroup.control(_commentsKey).value as String?;

    // Create additional fields
    final additionalFields = StockAdditionalDetails(
      version: "1.0.0",
      fields: [
        if (comments != null && comments.isNotEmpty)
          StockAdditinalField(key: "comments", value: comments),
        // StockAdditinalField(key: "teamCode", value: widget.warehouseData['teamCode']),
      ],
    );

    // Create the stock model
    final stockModel = StockModel(
      // dateOfEntry:date,
      tenantId: tenantId,
      clientReferenceId: clientReferenceId,
      facilityId: facilityId,
      productVariantId: productId,
      receiverId: receiverId,
      receiverType: "WAREHOUSE",
      senderId: facilityId,
      senderType: "WAREHOUSE",
      quantity: quantity.toString(),
      transactionType: "RECEIVED",
      additionalFields: additionalFields,
    );

    // final String tenantId = envConfig.variables.tenantId;
    // final String clientReferenceId = IdGen.i.identifier;

    // // Extract data from both forms
    // final facilityId = widget.warehouseData['facilityId'] as String;
    // final productId = formGroup.control(_productKey).value as String;
    // final receiverId = facilityId; // The current facility is the receiver
    // final senderId = formGroup.control(_receivedFromKey).value as String;
    // final quantity = formGroup.control(_quantityKey).value as int;
    // final comments = formGroup.control(_commentsKey).value as String?;

    // // Create additional fields
    // final additionalFields = StockAdditionalDetails(
    //   version: "1.0.0",
    //   schema: "Stock",
    //   fields: [
    //     if (comments != null && comments.isNotEmpty)
    //       StockAdditinalField(key: "comments", value: comments),
    //     StockAdditinalField(
    //         // key: "teamCode", value: widget.warehouseData['teamCode']
    //         ),
    //   ],
    // );

    // // Create the stock model
    // final stockModel = StockModel(
    //   tenantId: tenantId,
    //   clientReferenceId: clientReferenceId,
    //   facilityId: facilityId,
    //   productVariantId: productId,
    //   receiverId: receiverId,
    //   receiverType:
    //       "WAREHOUSE", // According to Swagger, this should be WAREHOUSE
    //   senderId: senderId,
    //   senderType: "WAREHOUSE", // According to Swagger, this should be WAREHOUSE
    //   quantity: quantity.toString(),
    //   transactionType: "RECEIVED",
    //   additionalFields: additionalFields,
    //   nonRecoverableError: false,
    // );

    // Dispatch the create event via StockBloc
    context.read<StockBloc>().add(
          StockEvent.create(model: stockModel),
        );

    // Listen for the state change
    context.read<StockBloc>().stream.listen((state) {
      state.maybeWhen(
        createSuccess: (stock) {
          // Navigate to success page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessPage(),
            ),
          );
        },
        failure: (message) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
            ),
          );
        },
        orElse: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocProvider<FacilityBloc>(
        create: (context) => FacilityBloc(
            facilityDataRepository:
                context.repository<FacilityModel, FacilitySearchModel>(),
            projectFacilityDataRepository: context
                .repository<ProjectFacilityModel, ProjectFacilitySearchModel>())
          ..add(FacilityLoadForProjectEvent(
              projectId: context.selectedProject.id)),
        child: BlocProvider<inventoryManagement.InventoryProductVariantBloc>(
          create: (context) => inventoryManagement.InventoryProductVariantBloc(
            productVariantDataRepository: context
                .repository<ProductVariantModel, ProductVariantSearchModel>(),
            projectResourceDataRepository: context
                .repository<ProjectResourceModel, ProjectResourceSearchModel>(),
          )..add(
              inventoryManagement.ProductVariantLoadEvent(
                query: ProjectResourceSearchModel(
                  projectId: [context.selectedProject.id],
                ),
              ),
            ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(localizations.translate('Received Stock Details')),
            ),
            body: ReactiveFormBuilder(
              form: () => buildForm(),
              builder:
                  (BuildContext context, FormGroup formGroup, Widget? child) {
                return ScrollableContent(
                  enableFixedDigitButton: true,
                  footer: DigitCard(
                    margin: const EdgeInsets.all(16),
                    children: [
                      DigitButton(
                        label: localizations.translate("Submit"),
                        type: DigitButtonType.primary,
                        size: DigitButtonSize.large,
                        mainAxisSize: MainAxisSize.max,
                        onPressed: () => _submitForm(formGroup),
                      ),
                    ],
                  ),
                  children: [
                    DigitCard(
                      margin: const EdgeInsets.all(16),
                      children: [
                        // Product selection field
                        // ReactiveWrapperField(
                        //   formControlName: _productKey,
                        //   validationMessages: {
                        //     'required': (_) =>
                        //         localizations.translate("Product is required"),
                        //   },
                        //   builder: (field) => LabeledField(
                        //     label: localizations.translate("Select product"),
                        //     isRequired: true,
                        //     child: DigitDropdown<String>(
                        //       items: const [
                        //         DropdownItem(name: 'SPAQ 1', code: 'SPAQ1'),
                        //         DropdownItem(name: 'SPAQ 2', code: 'SPAQ2'),
                        //         // Add more products as needed
                        //       ],
                        //       onSelect: (value) {
                        //         formGroup.control(_productKey).value = value.code;
                        //       },
                        //       emptyItemText:
                        //           localizations.translate('No match found'),
                        //       errorMessage: formGroup.control(_productKey).hasErrors
                        //           ? localizations.translate(
                        //               'Field is required',
                        //             )
                        //           : null,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 15),

                        BlocBuilder<FacilityBloc, FacilityState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const Offstage(),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              fetched: (facilities, allFacilities) {
                                return ReactiveWrapperField(
                                  formControlName: _receivedFromKey,
                                  builder: (field) => LabeledField(
                                    label: localizations
                                        .translate('Select receiver id'),
                                    capitalizedFirstLetter: false,
                                    isRequired: true,
                                    child: DigitDropdown<FacilityModel>(
                                      items: allFacilities
                                          .map((f) => DropdownItem(
                                              name: 'PF_${f.id}', code: f.id))
                                          .toList(),
                                      onSelect: (value) {
                                        formGroup
                                            .control(_receivedFromKey)
                                            .value = value.code;
                                      },
                                      emptyItemText: localizations
                                          .translate('No match found'),
                                      errorMessage: formGroup
                                              .control(_receivedFromKey)
                                              .hasErrors
                                          ? localizations.translate(
                                              'Field is required',
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        BlocBuilder<
                            inventoryManagement.InventoryProductVariantBloc,
                            inventoryManagement.InventoryProductVariantState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const Offstage(),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              // empty: () => Center(
                              //   child: Text(localizations.translate(
                              //     i18.stockDetails.noProductsFound,
                              //   )),
                              // ),
                              fetched: (productVariants) {
                                return ReactiveWrapperField(
                                  formControlName: _productKey,
                                  builder: (field) => LabeledField(
                                    label: localizations.translate(
                                      'select Product',
                                    ),
                                    isRequired: true,
                                    child: DigitDropdown<ProductVariantModel>(
                                      items: productVariants
                                          .map((variant) => DropdownItem(
                                                name: localizations.translate(
                                                  variant.sku ?? variant.id,
                                                ),
                                                code: variant.id,
                                              ))
                                          .toList(),
                                      onSelect: (value) {
                                        /// Find the selected
                                        formGroup.control(_productKey).value =
                                            value.code;
                                      },
                                      emptyItemText: localizations
                                          .translate('No match found'),
                                      errorMessage: formGroup
                                              .control(_productKey)
                                              .hasErrors
                                          ? localizations.translate(
                                              'Field is required',
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        // Received From field
                        // ReactiveWrapperField(
                        //   formControlName: _receivedFromKey,
                        //   validationMessages: {
                        //     'required': (_) => localizations
                        //         .translate("Received from is required"),
                        //   },
                        //   builder: (field) => LabeledField(
                        //     label: localizations.translate("Received from"),
                        //     isRequired: true,
                        //     child: DigitDropdown<String>(
                        //       items: const [
                        //         DropdownItem(
                        //             name: 'District Health Facility 1',
                        //             code: 'DHF1'),
                        //         DropdownItem(
                        //             name: 'District Health Facility 2',
                        //             code: 'DHF2'),
                        //         // Add more facilities as needed
                        //       ],
                        //       onSelect: (value) {
                        //         formGroup.control(_receivedFromKey).value =
                        //             value.code;
                        //       },
                        //       emptyItemText:
                        //           localizations.translate('No match found'),
                        //       errorMessage:
                        //           formGroup.control(_receivedFromKey).hasErrors
                        //               ? localizations.translate(
                        //                   'Field is required',
                        //                 )
                        //               : null,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 15),

                        // Quantity field
                        ReactiveWrapperField(
                          formControlName: _quantityKey,
                          validationMessages: {
                            'required': (_) =>
                                localizations.translate("Quantity is required"),
                          },
                          builder: (field) => LabeledField(
                            label: localizations.translate("Quantity received"),
                            isRequired: true,
                            child: DigitTextFormInput(
                              onChange: (value) =>
                                  // formGroup.control(_quantityKey).value = Value,
                                  formGroup.control(_quantityKey).value =
                                      int.tryParse(value) ?? 0,
                              // formControlName: _quantityKey,
                              helpText:
                                  localizations.translate("Enter quantity"),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Comments field (optional)
                        ReactiveWrapperField(
                          formControlName: _commentsKey,
                          builder: (field) => LabeledField(
                            label: localizations.translate("Comments"),
                            child: DigitTextFormInput(
                              onChange: (value) =>
                                  formGroup.control(_commentsKey).value = value,
                              helpText:
                                  localizations.translate("Enter comments"),
                              maxLength: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}

// Third page - Success Page
class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate("Success")),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: DigitCard(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            Text(
              localizations.translate("Stock Entry Successful"),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.translate(
                  "The stock record has been successfully created. You can view this record in your inventory reports."),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DigitButton(
              label: localizations.translate("Back to Home"),
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Return to stock entry page to create another record
                Navigator.pop(context);
              },
              child: Text(
                localizations.translate("Create Another Record"),
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
