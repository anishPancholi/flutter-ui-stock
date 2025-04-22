import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:digit_ui_components/utils/app_logger.dart';

// Import your app-specific files
import '../data/repositories/remote/stock.dart';
import '../models/entities/stock.dart'; // Contains StockModel, StockAdditionalDetails, StockAdditinalField
import '../utils/environment_config.dart';
// import '../utils/id_gen.dart';  // For generating unique IDs

// Import your models, blocs, and utilities.
import 'package:digit_data_model/data_model.dart'; // for StockModel, etc.
import '../router/app_router.dart';

import 'package:digit_data_model/utils/utils.dart';

import '../blocs/localization/app_localization.dart';
import '../blocs/stock_bloc.dart';

class CombinedStockEntryPage extends StatefulWidget {
  final StockModel? initialModel;
  const CombinedStockEntryPage({super.key, this.initialModel});

  @override
  _CombinedStockEntryPageState createState() => _CombinedStockEntryPageState();
}

class _CombinedStockEntryPageState extends State<CombinedStockEntryPage> {
  // Warehouse Section Keys
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
  static const String _referenceIdKey = 'referenceId';
  static const String _referenceIdTypeKey = 'referenceIdType';
  static const String _transactingPartyIdKey = 'transactingPartyId';
  static const String _transactingPartyTypeKey = 'transactingPartyType';

  // Received Stock Section Keys
  static const String _receivedFromKey = 'receivedFrom';
  static const String _netsKey = 'nets';
  static const String _vehicleKey = 'vehicle';
  static const String _commentsKey = 'comments';
  static const String _balesScannedKey = 'balesScanned';

  // Use a Reactive Form to handle all fields
  late FormGroup form;

  // Control the display of sections
  bool _showReceivedSection = false;

  // Get environment variables
  final String tenantId = envConfig.variables.tenantId;

  @override
  void initState() {
    super.initState();
    // Initialize the form with default values or existing model values
    form = FormGroup({
      // Warehouse fields
      _dateKey: FormControl<String>(
          value: widget.initialModel?.dateOfEntry != null
              ? DateTime.fromMillisecondsSinceEpoch(
                      widget.initialModel!.dateOfEntry!)
                  .toString()
              : "25 Jul 2022",
          validators: [Validators.required]),
      _adminUnitKey: FormControl<String>(
          value: "Solimbo", validators: [Validators.required]),
      _facilityKey: FormControl<String>(
          value: widget.initialModel?.facilityId ?? "",
          validators: [Validators.required]),
      _productVariantKey: FormControl<String>(
          value: widget.initialModel?.productVariantId ?? "",
          validators: [Validators.required]),
      _quantityKey: FormControl<String>(
          value: widget.initialModel?.quantity ?? "",
          validators: [Validators.required]),
      _wayBillNumberKey:
          FormControl<String>(value: widget.initialModel?.wayBillNumber ?? ""),
      _transactionTypeKey: FormControl<String>(
          value: widget.initialModel?.transactionType ?? "RECEIVED",
          validators: [Validators.required]),
      _transactionReasonKey: FormControl<String>(
          value: widget.initialModel?.transactionReason ?? "RECEIVED"),
      _senderIdKey:
          FormControl<String>(value: widget.initialModel?.senderId ?? ""),
      _senderTypeKey:
          FormControl<String>(value: widget.initialModel?.senderType ?? ""),
      _receiverIdKey:
          FormControl<String>(value: widget.initialModel?.receiverId ?? ""),
      _receiverTypeKey:
          FormControl<String>(value: widget.initialModel?.receiverType ?? ""),
      _referenceIdKey:
          FormControl<String>(value: widget.initialModel?.referenceId ?? "C-1"),
      _referenceIdTypeKey: FormControl<String>(
          value: widget.initialModel?.referenceIdType ?? "PROJECT"),
      _transactingPartyIdKey: FormControl<String>(
          value: widget.initialModel?.transactingPartyId ?? ""),
      _transactingPartyTypeKey: FormControl<String>(
          value: widget.initialModel?.transactingPartyType ?? "WAREHOUSE"),

      // Received Stock fields
      _receivedFromKey: FormControl<String>(
          value: "Provincial warehouse 1", validators: [Validators.required]),
      _netsKey: FormControl<String>(value: ""),
      _vehicleKey: FormControl<String>(value: ""),
      _commentsKey: FormControl<String>(value: ""),
      _balesScannedKey: FormControl<int>(value: 150),
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    // Instantiate repository and BLoC
    final stockRepository = StockRepository(Dio());

    return BlocProvider(
      create: (_) => StockBloc(stockRepository),
      child: BlocListener<StockBloc, StockState>(
        listener: (context, state) {
          state.maybeWhen(
            createSuccess: (stock) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SuccessPage(),
                ),
              );
            },
            failure: (message) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(localizations.translate("Error")),
                  content: Text(message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(localizations.translate("OK")),
                    ),
                  ],
                ),
              );
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(localizations.translate("Stock Entry")),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  localizations.translate("Help"),
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline, color: Colors.orange),
                onPressed: () {},
              ),
            ],
          ),
          body: ReactiveFormBuilder(
            form: () => form,
            builder: (context, formGroup, child) {
              return ScrollableContent(
                enableFixedDigitButton: true,
                header: const SizedBox.shrink(),
                footer: const SizedBox
                    .shrink(), // Added to ensure footer is non-null
                children: [
                  if (!_showReceivedSection) ...[
                    _buildWarehouseSection(formGroup, localizations),
                    const SizedBox(height: 16),
                    Center(
                      child: DigitButton(
                        label: localizations.translate("Next"),
                        type: DigitButtonType.primary,
                        size: DigitButtonSize.large,
                        onPressed: () {
                          form.markAllAsTouched();
                          if (form.valid) {
                            setState(() {
                              _showReceivedSection = true;
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(localizations
                                    .translate("Validation Error")),
                                content: Text(localizations.translate(
                                    "Please fill all required fields")),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(localizations.translate("OK")),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                  if (_showReceivedSection) ...[
                    _buildReceivedSection(formGroup, localizations),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DigitButton(
                          label: localizations.translate("Back"),
                          type: DigitButtonType.secondary,
                          size: DigitButtonSize.large,
                          onPressed: () {
                            setState(() {
                              _showReceivedSection = false;
                            });
                          },
                        ),
                        const SizedBox(width: 16),
                        DigitButton(
                          label: localizations.translate("Submit"),
                          type: DigitButtonType.primary,
                          size: DigitButtonSize.large,
                          onPressed: () => _submitForm(formGroup),
                        ),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Build the warehouse section UI
  Widget _buildWarehouseSection(
      FormGroup formGroup, AppLocalizations localizations) {
    return DigitCard(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      children: [
        // Title for the warehouse section
        Text(
          localizations.translate("Warehouse Information"),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Date of receipt
        ReactiveWrapperField(
          formControlName: _dateKey,
          validationMessages: {
            'required': (object) => localizations.translate("Date is required"),
          },
          builder: (field) => LabeledField(
            label: localizations.translate("Date of receipt *"),
            isRequired: true,
            child: DigitTextFormInput(
              onChange: (value) => formGroup.control(_dateKey).value = value,
              initialValue: formGroup.control(_dateKey).value,
              errorMessage: field.errorText,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Administrative unit
        ReactiveWrapperField(
          formControlName: _adminUnitKey,
          validationMessages: {
            'required': (object) =>
                localizations.translate("Administrative unit is required"),
          },
          builder: (field) => LabeledField(
            label: localizations.translate("Administrative unit*"),
            isRequired: true,
            child: DigitTextFormInput(
              onChange: (value) =>
                  formGroup.control(_adminUnitKey).value = value,
              initialValue: formGroup.control(_adminUnitKey).value,
              errorMessage: field.errorText,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Facility
        ReactiveWrapperField(
          formControlName: _facilityKey,
          validationMessages: {
            'required': (object) =>
                localizations.translate("Facility is required"),
          },
          builder: (field) => LabeledField(
            label: localizations.translate("Facility*"),
            isRequired: true,
            child: DigitTextFormInput(
              controller: TextEditingController(
                text: formGroup.control(_facilityKey).value,
              ),
              onChange: (value) =>
                  formGroup.control(_facilityKey).value = value,
              errorMessage: field.errorText,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Product Variant
        ReactiveWrapperField(
          formControlName: _productVariantKey,
          validationMessages: {
            'required': (object) =>
                localizations.translate("Product Variant is required"),
          },
          builder: (field) => LabeledField(
            label: localizations.translate("Product Variant*"),
            isRequired: true,
            child: DigitTextFormInput(
              onChange: (value) =>
                  formGroup.control(_productVariantKey).value = value,
              initialValue: formGroup.control(_productVariantKey).value,
              errorMessage: field.errorText,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Quantity
        ReactiveWrapperField(
          formControlName: _quantityKey,
          validationMessages: {
            'required': (object) =>
                localizations.translate("Quantity is required"),
          },
          builder: (field) => LabeledField(
            label: localizations.translate("Quantity received*"),
            isRequired: true,
            child: DigitTextFormInput(
              keyboardType: TextInputType.number,
              onChange: (value) =>
                  formGroup.control(_quantityKey).value = value,
              initialValue: formGroup.control(_quantityKey).value,
              errorMessage: field.errorText,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Waybill number
        LabeledField(
          label: localizations.translate("Waybill number"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_wayBillNumberKey).value = value,
            initialValue: formGroup.control(_wayBillNumberKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Reference ID
        LabeledField(
          label: localizations.translate("Reference ID"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_referenceIdKey).value = value,
            initialValue: formGroup.control(_referenceIdKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Reference ID Type
        LabeledField(
          label: localizations.translate("Reference ID Type"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_referenceIdTypeKey).value = value,
            initialValue: formGroup.control(_referenceIdTypeKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Transaction Type
        ReactiveWrapperField(
          formControlName: _transactionTypeKey,
          validationMessages: {
            'required': (object) =>
                localizations.translate("Transaction Type is required"),
          },
          builder: (field) => LabeledField(
            label: localizations.translate("Transaction Type*"),
            isRequired: true,
            child: DigitTextFormInput(
              onChange: (value) =>
                  formGroup.control(_transactionTypeKey).value = value,
              initialValue: formGroup.control(_transactionTypeKey).value,
              errorMessage: field.errorText,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Transaction Reason
        LabeledField(
          label: localizations.translate("Transaction Reason"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_transactionReasonKey).value = value,
            initialValue: formGroup.control(_transactionReasonKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Transacting Party ID
        LabeledField(
          label: localizations.translate("Transacting Party ID"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_transactingPartyIdKey).value = value,
            initialValue: formGroup.control(_transactingPartyIdKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Transacting Party Type
        LabeledField(
          label: localizations.translate("Transacting Party Type"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_transactingPartyTypeKey).value = value,
            initialValue: formGroup.control(_transactingPartyTypeKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Sender ID
        LabeledField(
          label: localizations.translate("Sender ID"),
          child: DigitTextFormInput(
            onChange: (value) => formGroup.control(_senderIdKey).value = value,
            initialValue: formGroup.control(_senderIdKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Sender Type
        LabeledField(
          label: localizations.translate("Sender Type"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_senderTypeKey).value = value,
            initialValue: formGroup.control(_senderTypeKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Receiver ID
        LabeledField(
          label: localizations.translate("Receiver ID"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_receiverIdKey).value = value,
            initialValue: formGroup.control(_receiverIdKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Receiver Type
        LabeledField(
          label: localizations.translate("Receiver Type"),
          child: DigitTextFormInput(
            onChange: (value) =>
                formGroup.control(_receiverTypeKey).value = value,
            initialValue: formGroup.control(_receiverTypeKey).value,
          ),
        ),
      ],
    );
  }

  // Build the received stock section UI
  Widget _buildReceivedSection(
      FormGroup formGroup, AppLocalizations localizations) {
    return DigitCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      children: [
        // Title for the received stock section
        Text(
          localizations.translate("Received Stock Details"),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Received from
        ReactiveWrapperField(
          formControlName: _receivedFromKey,
          validationMessages: {
            'required': (object) =>
                localizations.translate("Received from is required"),
          },
          builder: (field) => LabeledField(
            label: localizations.translate("Received from*"),
            isRequired: true,
            child: DigitTextFormInput(
              onChange: (value) =>
                  formGroup.control(_receivedFromKey).value = value,
              initialValue: formGroup.control(_receivedFromKey).value,
              errorMessage: field.errorText,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Number of nets
        LabeledField(
          label: localizations
              .translate("Number of nets indicated on the waybill"),
          child: DigitTextFormInput(
            keyboardType: TextInputType.number,
            onChange: (value) => formGroup.control(_netsKey).value = value,
            initialValue: formGroup.control(_netsKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Vehicle number
        LabeledField(
          label: localizations.translate("Vehicle number"),
          child: DigitTextFormInput(
            onChange: (value) => formGroup.control(_vehicleKey).value = value,
            initialValue: formGroup.control(_vehicleKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Comments
        LabeledField(
          label: localizations.translate("Comments"),
          child: DigitTextFormInput(
            maxLength: 3,
            onChange: (value) => formGroup.control(_commentsKey).value = value,
            initialValue: formGroup.control(_commentsKey).value,
          ),
        ),
        const SizedBox(height: 15),

        // Bales scanned
        LabeledField(
          label: localizations.translate("Number of bales scanned"),
          child: DigitTextFormInput(
            keyboardType: TextInputType.number,
            onChange: (value) => formGroup.control(_balesScannedKey).value =
                int.tryParse(value) ?? 0,
            initialValue:
                formGroup.control(_balesScannedKey).value?.toString() ?? "150",
          ),
        ),
      ],
    );
  }

  // Submit form data
  void _submitForm(FormGroup formGroup) {
    formGroup.markAllAsTouched();
    if (!formGroup.valid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:
              Text(AppLocalizations.of(context).translate("Validation Error")),
          content: Text(AppLocalizations.of(context)
              .translate("Please fill all required fields (marked with *)")),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).translate("OK")),
            ),
          ],
        ),
      );
      return;
    }

    // Extract form values and prepare model
    final String tenantId = envConfig.variables.tenantId;
    final String clientReferenceId = IdGen.i.identifier;

    // Warehouse fields
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
    final String? referenceId =
        formGroup.control(_referenceIdKey).value as String?;
    final String? referenceIdType =
        formGroup.control(_referenceIdTypeKey).value as String?;
    final String? transactingPartyId =
        formGroup.control(_transactingPartyIdKey).value as String?;
    final String? transactingPartyType =
        formGroup.control(_transactingPartyTypeKey).value as String?;
    final int dateOfEntry = DateTime.now().millisecondsSinceEpoch;

    // Received stock fields
    final String receivedFrom =
        formGroup.control(_receivedFromKey).value as String;
    final String nets = formGroup.control(_netsKey).value as String;
    final String vehicle = formGroup.control(_vehicleKey).value as String;
    final String comments = formGroup.control(_commentsKey).value as String;
    final int balesScanned = formGroup.control(_balesScannedKey).value as int;

    // Create additionalFields using additional details
    final additionalFields = StockAdditionalDetails(
      version: "1.0.0",
      fields: [
        StockAdditinalField(key: "receivedFrom", value: receivedFrom),
        StockAdditinalField(key: "nets", value: nets),
        StockAdditinalField(key: "vehicle", value: vehicle),
        StockAdditinalField(key: "comments", value: comments),
        StockAdditinalField(
            key: "balesScanned", value: balesScanned.toString()),
      ],
    );

    // Create the stock model
    final stockModel = StockModel(
      tenantId: tenantId,
      clientReferenceId: clientReferenceId,
      facilityId: facilityId,
      productVariantId: productVariantId,
      quantity: quantity,
      wayBillNumber: wayBillNumber,
      referenceId: referenceId,
      referenceIdType: referenceIdType,
      transactionType: transactionType,
      transactionReason: transactionReason,
      transactingPartyId: transactingPartyId,
      transactingPartyType: transactingPartyType,
      senderId: senderId,
      senderType: senderType,
      receiverId: receiverId,
      receiverType: receiverType,
      dateOfEntry: dateOfEntry,
      additionalFields: additionalFields,
    );

    // Dispatch the create event via StockBloc
    context.read<StockBloc>().add(
          StockEvent.create(model: stockModel),
        );
  }
}

// ========== SUCCESS PAGE ==========

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

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

      // body: Center(
      //   child: DigitCard(
      //     margin: const EdgeInsets.all(16),
      //     padding: const EdgeInsets.all(24),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         const Icon(Icons.check_circle, color: Colors.green, size: 64),
      //         const SizedBox(height: 16),
      //         Text(
      //           localizations.translate("Stock Entry Successful"),
      //           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //           textAlign: TextAlign.center,
      //         ),
      //         const SizedBox(height: 16),
      //         Text(
      //           localizations.translate("The stock record has been successfully created. You can view this record in your inventory reports."),
      //           textAlign: TextAlign.center,
      //         ),
      //         const SizedBox(height: 24),
      //         DigitButton(
      //           label: localizations.translate("Back to Home"),
      //           onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      //           type: DigitButtonType.primary,
      //           size: DigitButtonSize.large,
      //         ),
      //         const SizedBox(height: 16),
      //         TextButton(
      //           onPressed: () {
      //             // Return to stock entry page to create another record
      //             Navigator.pop(context);
      //           },
      //           child: Text(
      //             localizations.translate("Create Another Record"),
      //             style: const TextStyle(color: Colors.blue),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
