import 'package:digit_data_model/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import '../../../models/entities/stock.dart';
import '../blocs/stock_bloc.dart';
import '../../../utils/environment_config.dart';

class StockCreatePage extends StatefulWidget {
  const StockCreatePage({super.key});

  @override
  State<StockCreatePage> createState() => _StockCreatePageState();
}

class _StockCreatePageState extends State<StockCreatePage> {
  final TextEditingController _clientReferenceIdController =
      TextEditingController();
  final TextEditingController _facilityIdController = TextEditingController();
  final TextEditingController _productVariantIdController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _wayBillNumberController =
      TextEditingController();
  final TextEditingController _transactionTypeController =
      TextEditingController();
  final TextEditingController _transactionReasonController =
      TextEditingController();
  final TextEditingController _senderIdController = TextEditingController();
  final TextEditingController _senderTypeController = TextEditingController();
  final TextEditingController _receiverIdController = TextEditingController();
  final TextEditingController _receiverTypeController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _clientReferenceIdController.dispose();
    _facilityIdController.dispose();
    _productVariantIdController.dispose();
    _quantityController.dispose();
    _wayBillNumberController.dispose();
    _transactionTypeController.dispose();
    _transactionReasonController.dispose();
    _senderIdController.dispose();
    _senderTypeController.dispose();
    _receiverIdController.dispose();
    _receiverTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Stock'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<StockBloc, StockState>(
        listener: (context, state) {
          state.maybeMap(
            createSuccess: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Stock created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop(); // Return to previous screen
            },
            failure: (state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
              setState(() {
                _isSubmitting = false;
              });
            },
            loading: (_) {
              setState(() {
                _isSubmitting = true;
              });
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DigitCard(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Stock Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Required fields
                  LabeledField(
                    label: 'Client Reference ID *',
                    child: DigitTextFormInput(
                      controller: _clientReferenceIdController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Facility ID *',
                    child: DigitTextFormInput(
                      controller: _facilityIdController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Product Variant ID *',
                    child: DigitTextFormInput(
                      controller: _productVariantIdController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Quantity *',
                    child: DigitTextFormInput(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Optional fields
                  LabeledField(
                    label: 'Way Bill Number',
                    child: DigitTextFormInput(
                      controller: _wayBillNumberController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Transaction Type *',
                    child: DigitTextFormInput(
                      controller: _transactionTypeController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Transaction Reason',
                    child: DigitTextFormInput(
                      controller: _transactionReasonController,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Sender & Receiver Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  LabeledField(
                    label: 'Sender ID',
                    child: DigitTextFormInput(
                      controller: _senderIdController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Sender Type',
                    child: DigitTextFormInput(
                      controller: _senderTypeController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Receiver ID',
                    child: DigitTextFormInput(
                      controller: _receiverIdController,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LabeledField(
                    label: 'Receiver Type',
                    child: DigitTextFormInput(
                      controller: _receiverTypeController,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  _isSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: _submitForm,
                          child: const Text(
                            'Create Stock',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),

                  // Cancel Button
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Validate required fields
    if (_clientReferenceIdController.text.isEmpty ||
        _facilityIdController.text.isEmpty ||
        _productVariantIdController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _transactionTypeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields (marked with *)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create the stock model
    final stockModel = StockModel(
      tenantId: envConfig.variables.tenantId,
      clientReferenceId: IdGen.i.identifier,
      facilityId: null,
      productVariantId: _productVariantIdController.text, //bloc
      quantity: _quantityController.text,
      wayBillNumber: _wayBillNumberController.text.isNotEmpty
          ? _wayBillNumberController.text
          : null,
      transactionType: _transactionTypeController.text,
      transactionReason: _transactionReasonController.text.isNotEmpty
          ? _transactionReasonController.text
          : null,
      senderId:
          _senderIdController.text.isNotEmpty ? _senderIdController.text : null,
      senderType: _senderTypeController.text.isNotEmpty
          ? _senderTypeController.text
          : null,
      receiverId: _receiverIdController.text.isNotEmpty
          ? _receiverIdController.text
          : null,
      receiverType: _receiverTypeController.text.isNotEmpty
          ? _receiverTypeController.text
          : null,
      // Add current date of entry
      dateOfEntry: DateTime.now().millisecondsSinceEpoch,
      // Additional fields if needed
      additionalFields: StockAdditionalDetails(
        version: "1.0.0",
        fields: [],
      ),
    );

    // Dispatch the create event
    context.read<StockBloc>().add(
          StockEvent.create(model: stockModel),
        );
  }
}
