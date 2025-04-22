// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:digit_ui_components/digit_components.dart';
// import 'package:digit_ui_components/widgets/molecules/digit_card.dart';

// // Import your models, blocs, and utilities.
// import 'package:digit_data_model/data_model.dart'; // for StockModel, etc.
// // import 'package:your_app/blocs/facility/facility_bloc.dart';
// // import 'package:your_app/blocs/facility/facility_state.dart';
// import '../router/app_router.dart';

// import 'package:digit_data_model/utils/utils.dart';

// import '../blocs/localization/app_localization.dart';
// import '../blocs/stock_bloc.dart';
// import '../models/entities/stock.dart';
// import '../utils/environment_config.dart';
// import '../utils/typedefs.dart';

// // ********************* Main Warehouse App *********************
// class WarehouseApp extends StatelessWidget {
//   const WarehouseApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Warehouse Management',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF014354),
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF014354),
//           elevation: 0,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(const Color(0xFFFF7043)),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//             minimumSize:
//                 MaterialStateProperty.all(const Size(double.infinity, 50)),
//           ),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       // Providing FacilityBloc at this level so WarehouseDetailsPage can access it.
//       home: BlocProvider(
//         create: (context) => FacilityBloc(
//           facilityDataRepository: context.read<FacilityDataRepository>(),
//           projectFacilityDataRepository:
//               context.read<ProjectFacilityDataRepository>(),
//         )..add(const FacilityEvent.loadForProjectId(
//             projectId: 'default-project-id', // Replace with actual project ID
//           )),
//         child: WarehouseDetailsPage(),
//       ),
//     );
//   }
// }

// // ********************* Warehouse Details Page *********************
// class WarehouseDetailsPage extends StatefulWidget {
//   // Accept an optional StockModel; if not provided, defaults are used.
//   final StockModel? model;
//   WarehouseDetailsPage({
//     Key? key,
//     this.model,
//   }) : super(key: key);

//   @override
//   _WarehouseDetailsPageState createState() => _WarehouseDetailsPageState();
// }

// class _WarehouseDetailsPageState extends State<WarehouseDetailsPage> {
//   // Define form keys.
//   static const String _dateKey = 'date';
//   static const String _adminUnitKey = 'adminUnit';
//   static const String _facilityKey = 'facility';
//   static const String _productVariantKey = 'productVariant';
//   static const String _quantityKey = 'quantity';
//   static const String _wayBillNumberKey = 'wayBillNumber';
//   static const String _transactionTypeKey = 'transactionType';
//   static const String _transactionReasonKey = 'transactionReason';
//   static const String _senderIdKey = 'senderId';
//   static const String _senderTypeKey = 'senderType';
//   static const String _receiverIdKey = 'receiverId';
//   static const String _receiverTypeKey = 'receiverType';

//   // Facility data: selected facility id and text controller for display.
//   String? selectedFacilityId;
//   final TextEditingController _facilityController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize selected facility from model (if available) or default to "Facility 1"
//     selectedFacilityId = widget.model?.facilityId ?? "Facility 1";
//     _facilityController.text =
//         AppLocalizations.of(context).translate('FAC_${selectedFacilityId}');
//   }

//   @override
//   void dispose() {
//     _facilityController.dispose();
//     super.dispose();
//   }

//   // Build the Reactive Form Group.
//   FormGroup buildForm() {
//     // For simplicity, assume default text values for date and admin unit.
//     return fb.group(<String, Object>{
//       _dateKey: FormControl<String>(
//           value: widget.model?.dateOfEntry != null
//               ? DateTime.fromMillisecondsSinceEpoch(widget.model!.dateOfEntry!)
//                   .toString()
//               : "25 Jul 2022",
//           validators: [Validators.required]),
//       _adminUnitKey: FormControl<String>(
//           // value: widget.model?.administrativeUnit ?? "Solimbo",
//           value: "Solimbo",
//           validators: [Validators.required]),
//       _facilityKey: FormControl<String>(
//           value: selectedFacilityId, validators: [Validators.required]),
//       // Additional fields can be added here as required.
//       _productVariantKey: FormControl<String>(
//           value: widget.model?.productVariantId ?? "",
//           validators: [Validators.required]),
//       _quantityKey: FormControl<String>(
//           value: widget.model?.quantity ?? "",
//           validators: [Validators.required]),
//       _wayBillNumberKey:
//           FormControl<String>(value: widget.model?.wayBillNumber ?? ""),
//       _transactionTypeKey: FormControl<String>(
//           value: widget.model?.transactionType ?? "",
//           validators: [Validators.required]),
//       _transactionReasonKey:
//           FormControl<String>(value: widget.model?.transactionReason ?? ""),
//       _senderIdKey: FormControl<String>(value: widget.model?.senderId ?? ""),
//       _senderTypeKey:
//           FormControl<String>(value: widget.model?.senderType ?? ""),
//       _receiverIdKey:
//           FormControl<String>(value: widget.model?.receiverId ?? ""),
//       _receiverTypeKey:
//           FormControl<String>(value: widget.model?.receiverType ?? ""),
//     });
//   }

//   // onSubmit function using the reactive form controls.
//   void _submitForm(FormGroup formGroup) {
//     // Mark all controls as touched to trigger validation.
//     formGroup.markAllAsTouched();
//     if (!formGroup.valid) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill all required fields (marked with *)'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     final String tenantId = envConfig.variables.tenantId;
//     final String clientReferenceId = IdGen.i.identifier;
//     final String? facilityId = formGroup.control(_facilityKey).value as String?;
//     final String productVariantId =
//         formGroup.control(_productVariantKey).value as String;
//     final String quantity = formGroup.control(_quantityKey).value as String;
//     final String? wayBillNumber =
//         formGroup.control(_wayBillNumberKey).value as String?;
//     final String transactionType =
//         formGroup.control(_transactionTypeKey).value as String;
//     final String? transactionReason =
//         formGroup.control(_transactionReasonKey).value as String?;
//     final String? senderId = formGroup.control(_senderIdKey).value as String?;
//     final String? senderType =
//         formGroup.control(_senderTypeKey).value as String?;
//     final String? receiverId =
//         formGroup.control(_receiverIdKey).value as String?;
//     final String? receiverType =
//         formGroup.control(_receiverTypeKey).value as String?;
//     final int dateOfEntry = DateTime.now().millisecondsSinceEpoch;

//     final additionalFields = StockAdditionalDetails(
//       version: "1.0.0",
//       fields: [],
//     );

//     final stockModel = StockModel(
//       tenantId: tenantId,
//       clientReferenceId: clientReferenceId,
//       facilityId: facilityId,
//       productVariantId: productVariantId,
//       quantity: quantity,
//       wayBillNumber: wayBillNumber,
//       transactionType: transactionType,
//       transactionReason: transactionReason,
//       senderId: senderId,
//       senderType: senderType,
//       receiverId: receiverId,
//       receiverType: receiverType,
//       dateOfEntry: dateOfEntry,
//       additionalFields: additionalFields,
//     );

//     // Dispatch the create event via StockBloc.
//     context.read<StockBloc>().add(
//           StockEvent.create(model: stockModel),
//         );
//   }

//   // Facility selector using a modal bottom sheet.
//   void _showFacilitySelector(BuildContext context, FormGroup formGroup) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (BuildContext context) {
//         return BlocBuilder<FacilityBloc, FacilityState>(
//           builder: (context, state) {
//             if (state is FacilityLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is FacilityFetched) {
//               return Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Select Facility",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Expanded(
//                       child: ListView.separated(
//                         itemCount: state.facilities.length,
//                         separatorBuilder: (context, index) =>
//                             const Divider(height: 1),
//                         itemBuilder: (context, index) {
//                           final facility = state.facilities[index];
//                           final facilityName = AppLocalizations.of(context)
//                               .translate('FAC_${facility.id}');
//                           return ListTile(
//                             title: Text(facilityName),
//                             onTap: () {
//                               setState(() {
//                                 selectedFacilityId = facility.id;
//                                 _facilityController.text = facilityName;
//                                 formGroup.control(_facilityKey).value =
//                                     facility.id;
//                               });
//                               Navigator.pop(context);
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return const Center(child: Text("No Facility Data"));
//             }
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {},
//         ),
//         // For this example, we keep a static dropdown in the title.
//         title: DropdownButton<String>(
//           value: "Solimbo",
//           dropdownColor: const Color(0xFF014354),
//           style: const TextStyle(color: Colors.white),
//           icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
//           underline: Container(),
//           onChanged: (String? newValue) {},
//           items:
//               <String>['Solimbo'].map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         actions: [
//           IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.pop(context)),
//           TextButton(
//             child: const Text("Help", style: TextStyle(color: Colors.orange)),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.help_outline, color: Colors.orange),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ReactiveFormBuilder(
//           form: () => buildForm(),
//           builder: (BuildContext context, FormGroup formGroup, Widget? child) {
//             return ScrollableContent(
//               enableFixedDigitButton: true,
//               // Footer button using a DigitCard similar to your profile.dart example
//               footer: DigitCard(
//                 margin: const EdgeInsets.only(top: 16),
//                 children: [
//                   DigitButton(
//                     label: localizations.translate("Next"),
//                     type: DigitButtonType.primary,
//                     size: DigitButtonSize.large,
//                     mainAxisSize: MainAxisSize.max,
//                     onPressed: () => _submitForm(formGroup),
//                   ),
//                 ],
//               ),
//               header: const Column(
//                 children: [
//                   // You could add a header widget here if needed.
//                 ],
//               ),
//               children: [
//                 DigitCard(
//                   margin: const EdgeInsets.all(16),
//                   children: [
//                     ReactiveWrapperField(
//                       formControlName: _dateKey,
//                       validationMessages: {
//                         'required': (_) =>
//                             localizations.translate("Date is required"),
//                       },
//                       builder: (field) => LabeledField(
//                         label: localizations.translate("Date of receipt"),
//                         isRequired: true,
//                         child: DigitTextFormInput(
//                           onChange: (value) =>
//                               formGroup.control(_dateKey).value = value,
//                           initialValue: formGroup.control(_dateKey).value,
//                           // You can add suffix icons (e.g., calendar)
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     ReactiveWrapperField(
//                       formControlName: _adminUnitKey,
//                       validationMessages: {
//                         'required': (_) => localizations
//                             .translate("Administrative unit is required"),
//                       },
//                       builder: (field) => LabeledField(
//                         label: localizations.translate("Administrative unit*"),
//                         isRequired: true,
//                         child: DigitTextFormInput(
//                           onChange: (value) =>
//                               formGroup.control(_adminUnitKey).value = value,
//                           initialValue: formGroup.control(_adminUnitKey).value,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     // Facility field with dynamic selection.
//                     ReactiveWrapperField(
//                       formControlName: _facilityKey,
//                       validationMessages: {
//                         'required': (_) =>
//                             localizations.translate("Facility is required"),
//                       },
//                       builder: (field) => LabeledField(
//                         label: localizations.translate("Facility*"),
//                         isRequired: true,
//                         child: InkWell(
//                           onTap: () =>
//                               _showFacilitySelector(context, formGroup),
//                           child: IgnorePointer(
//                             child: DigitTextFormInput(
//                               controller: _facilityController,
//                               errorMessage: field.errorText,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Add additional fields as needed (e.g., productVariant, quantity, etc.)
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management/utils/extensions/extensions.dart'
    as inventoryExt;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';

import '../utils/extensions/extensions.dart' as util_extension;

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
  // Accept an optional StockModel; if not provided, defaults are used.
  final StockModel? model;
  WarehouseDetailsPage({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  _WarehouseDetailsPageState createState() => _WarehouseDetailsPageState();
}

class _WarehouseDetailsPageState extends State<WarehouseDetailsPage> {
  // Define form keys.
  static const String _dateKey = 'date';
  static const String _adminUnitKey = 'adminUnit';
  static const String _facilityKey = 'facility';
  static const String _productVariantKey = 'productVariant';
  static const String _quantityKey = 'quantity';
  static const String _wayBillNumberKey = 'wayBillNumber';
  static const String _transactionTypeKey = 'transactionType';
  static const String _transactionReasonKey = 'transactionReason';
  static const String _senderIdKey = 'senderId';
  static const String _senderTypeKey = 'senderType';
  static const String _receiverIdKey = 'receiverId';
  static const String _receiverTypeKey = 'receiverType';

  // Facility data: selected facility id and text controller for display.
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

  // Build the Reactive Form Group.
  FormGroup buildForm() {
    // For simplicity, assume default text values for date and admin unit.
    return fb.group(<String, Object>{
      _dateKey: FormControl<String>(
          value: widget.model?.dateOfEntry != null
              ? DateTime.fromMillisecondsSinceEpoch(widget.model!.dateOfEntry!)
                  .toString()
              : "25 Jul 2022",
          validators: [Validators.required]),
      _adminUnitKey: FormControl<String>(
          value: "Solimbo", validators: [Validators.required]),
      _facilityKey: FormControl<String>(
          value: selectedFacilityId ?? "", validators: [Validators.required]),
      // Additional fields can be added here as required.
      _productVariantKey: FormControl<String>(
          value: widget.model?.productVariantId ?? "",
          validators: [Validators.required]),
      _quantityKey: FormControl<String>(
          value: widget.model?.quantity ?? "",
          validators: [Validators.required]),
      _wayBillNumberKey:
          FormControl<String>(value: widget.model?.wayBillNumber ?? ""),
      _transactionTypeKey: FormControl<String>(
          value: widget.model?.transactionType ?? "",
          validators: [Validators.required]),
      _transactionReasonKey:
          FormControl<String>(value: widget.model?.transactionReason ?? ""),
      _senderIdKey: FormControl<String>(value: widget.model?.senderId ?? ""),
      _senderTypeKey:
          FormControl<String>(value: widget.model?.senderType ?? ""),
      _receiverIdKey:
          FormControl<String>(value: widget.model?.receiverId ?? ""),
      _receiverTypeKey:
          FormControl<String>(value: widget.model?.receiverType ?? ""),
    });
  }

  // onSubmit function using the reactive form controls.
  void _submitForm(FormGroup formGroup) {
    // Mark all controls as touched to trigger validation.
    formGroup.markAllAsTouched();
    if (!formGroup.valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields (marked with *)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String tenantId = envConfig.variables.tenantId;
    final String clientReferenceId = IdGen.i.identifier;
    final String? facilityId = formGroup.control(_facilityKey).value as String?;
    final String productVariantId =
        formGroup.control(_productVariantKey).value as String;
    final String quantity = formGroup.control(_quantityKey).value as String;
    final String? wayBillNumber =
        formGroup.control(_wayBillNumberKey).value as String?;
    final String transactionType =
        formGroup.control(_transactionTypeKey).value as String;
    final String? transactionReason =
        formGroup.control(_transactionReasonKey).value as String?;
    final String? senderId = formGroup.control(_senderIdKey).value as String?;
    final String? senderType =
        formGroup.control(_senderTypeKey).value as String?;
    final String? receiverId =
        formGroup.control(_receiverIdKey).value as String?;
    final String? receiverType =
        formGroup.control(_receiverTypeKey).value as String?;
    final int dateOfEntry = DateTime.now().millisecondsSinceEpoch;

    final additionalFields = StockAdditionalDetails(
      version: "1.0.0",
      fields: [],
    );

    final stockModel = StockModel(
      tenantId: tenantId,
      clientReferenceId: clientReferenceId,
      facilityId: facilityId,
      productVariantId: productVariantId,
      quantity: quantity,
      wayBillNumber: wayBillNumber,
      transactionType: transactionType,
      transactionReason: transactionReason,
      senderId: senderId,
      senderType: senderType,
      receiverId: receiverId,
      receiverType: receiverType,
      dateOfEntry: dateOfEntry,
      additionalFields: additionalFields,
    );

    // Dispatch the create event via StockBloc.
    context.read<StockBloc>().add(
          StockEvent.create(model: stockModel),
        );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return BlocProvider<FacilityBloc>(
      create: (context) => FacilityBloc(
          facilityDataRepository: inventoryExt
              .repository<FacilityModel, FacilitySearchModel>(context),
          projectFacilityDataRepository: inventoryExt.repository<
              ProjectFacilityModel, ProjectFacilitySearchModel>(context))
        ..add(
            FacilityLoadForProjectEvent(projectId: context.selectedProject.id)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          // For this example, we keep a static dropdown in the title.
          title: DropdownButton<String>(
            value: "Solimbo",
            dropdownColor: const Color(0xFF014354),
            style: const TextStyle(color: Colors.white),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            underline: Container(),
            onChanged: (String? newValue) {},
            items: <String>['Solimbo']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            TextButton(
              child:
                  const Text("Help!!", style: TextStyle(color: Colors.orange)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.orange),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ReactiveFormBuilder(
            form: () => buildForm(),
            builder:
                (BuildContext context, FormGroup formGroup, Widget? child) {
              return ScrollableContent(
                enableFixedDigitButton: true,
                // Footer button using a DigitCard similar to your profile.dart example
                footer: DigitCard(
                  margin: const EdgeInsets.only(top: 16),
                  children: [
                    DigitButton(
                      label: localizations.translate("Next"),
                      type: DigitButtonType.primary,
                      size: DigitButtonSize.large,
                      mainAxisSize: MainAxisSize.max,
                      onPressed: () => _submitForm(formGroup),
                    ),
                  ],
                ),
                header: const Column(
                  children: [
                    // You could add a header widget here if needed.
                  ],
                ),
                children: [
                  DigitCard(
                    margin: const EdgeInsets.all(16),
                    children: [
                      ReactiveWrapperField(
                        formControlName: _dateKey,
                        validationMessages: {
                          'required': (_) =>
                              localizations.translate("Date is required"),
                        },
                        builder: (field) => LabeledField(
                          label: localizations.translate("Date of receipt"),
                          isRequired: true,
                          child: DigitTextFormInput(
                            onChange: (value) =>
                                formGroup.control(_dateKey).value = value,
                            initialValue: formGroup.control(_dateKey).value,
                            // You can add suffix icons (e.g., calendar)
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ReactiveWrapperField(
                        formControlName: _adminUnitKey,
                        validationMessages: {
                          'required': (_) => localizations
                              .translate("Administrative unit is required"),
                        },
                        builder: (field) => LabeledField(
                          label:
                              localizations.translate("Administrative unit*"),
                          isRequired: true,
                          child: DigitTextFormInput(
                            onChange: (value) =>
                                formGroup.control(_adminUnitKey).value = value,
                            initialValue:
                                formGroup.control(_adminUnitKey).value,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Updated Facility field implementation using the pattern from your second snippet
                      BlocBuilder<FacilityBloc, FacilityState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const Offstage(),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            fetched: (facilities, allFacilities) {
                              return Column(
                                children: [
                                  ReactiveWrapperField(
                                    formControlName: 'facilityKey',
                                    builder: (field) => LabeledField(
                                      label: localizations.translate(
                                        'Select Facility',
                                      ),
                                      capitalizedFirstLetter: false,
                                      isRequired: true,
                                      child: DigitDropdown<FacilityModel>(
                                        items: facilities
                                            .map((f) => DropdownItem(
                                                name: 'PF_${f.id}', code: f.id))
                                            .toList(),
                                        onSelect: (value) {
                                          formGroup
                                              .control('facilityKey')
                                              .value = value.code;
                                        },
                                        emptyItemText: localizations
                                            .translate('No match found'),
                                        errorMessage: formGroup
                                                .control('facilityKey')
                                                .hasErrors
                                            ? localizations.translate(
                                                'Field is required',
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),

                      // Additional fields as needed...
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
