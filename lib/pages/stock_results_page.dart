import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import '../blocs/stock_bloc.dart';

class StockResultsPage extends StatelessWidget {
  const StockResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Results')),
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          return state.map(
            initial: (_) =>
                const Center(child: Text('No search performed yet')),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            searchSuccess: (state) {
              if (state.stocks.isEmpty) {
                return const Center(child: Text('No stocks found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.stocks.length,
                itemBuilder: (context, index) {
                  final stock = state.stocks[index];
                  return DigitCard(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 12),
                    children: [
                      Text(
                        'Reference ID: ${stock.referenceId ?? "N/A"} (${stock.referenceIdType ?? "N/A"})',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      // Wrap the content in a SingleChildScrollView for vertical scrolling
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (stock.clientReferenceId != null)
                                Text(
                                    'Client Reference ID: ${stock.clientReferenceId}'),
                              if (stock.id != null)
                                Text('Stock ID: ${stock.id}'),
                              if (stock.tenantId != null)
                                Text('Tenant ID: ${stock.tenantId}'),
                              if (stock.facilityId != null)
                                Text('Facility ID: ${stock.facilityId}'),
                              if (stock.productVariantId != null)
                                Text(
                                    'Product Variant ID: ${stock.productVariantId}'),
                              if (stock.quantity != null)
                                Text('Quantity: ${stock.quantity}'),
                              if (stock.transactionType != null)
                                Text(
                                    'Transaction Type: ${stock.transactionType}'),
                              if (stock.transactionReason != null)
                                Text(
                                    'Transaction Reason: ${stock.transactionReason}'),
                              if (stock.wayBillNumber != null)
                                Text('Way Bill Number: ${stock.wayBillNumber}'),
                              if (stock.transactingPartyId != null)
                                Text(
                                    'Transacting Party ID: ${stock.transactingPartyId}'),
                              if (stock.transactingPartyType != null)
                                Text(
                                    'Transacting Party Type: ${stock.transactingPartyType}'),

                              // Display additional fields if available
                              if (stock.additionalFields?.fields != null &&
                                  stock.additionalFields!.fields!
                                      .isNotEmpty) ...[
                                const SizedBox(height: 8),
                                const Text('Additional Fields:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                ...stock.additionalFields!.fields!
                                    .map((field) =>
                                        Text('${field.key}: ${field.value}'))
                                    .toList(),
                              ],

                              // if (stock.isDeleted == true)
                              //   const Text('Status: Deleted',
                              //       style: TextStyle(color: Colors.red)),

                              // if (stock.auditDetails != null) ...[
                              //   const SizedBox(height: 8),
                              //   const Text('Audit Details:',
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 14)),
                              //   if (stock.auditDetails?.createdBy != null)
                              //     Text(
                              //         'Created By: ${stock.auditDetails!.createdBy}'),
                              //   if (stock.auditDetails?.createdTime != null)
                              //     Text(
                              //         'Created Time: ${_formatTimestamp(stock.auditDetails!.createdTime!)}'),
                              //   if (stock.auditDetails?.lastModifiedBy != null)
                              //     Text(
                              //         'Last Modified By: ${stock.auditDetails!.lastModifiedBy}'),
                              //   if (stock.auditDetails?.lastModifiedTime !=
                              //       null)
                              //     Text(
                              //         'Last Modified: ${_formatTimestamp(stock.auditDetails!.lastModifiedTime!)}'),
                              // ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            createSuccess: (state) => Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Stock created successfully:'),
                    const SizedBox(height: 16),
                    DigitCard(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Text(
                          'Reference ID: ${state.stock.referenceId ?? "N/A"}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        // Wrap content in SingleChildScrollView
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.6,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state.stock.clientReferenceId != null)
                                  Text(
                                      'Client Reference ID: ${state.stock.clientReferenceId}'),
                                if (state.stock.id != null)
                                  Text('Stock ID: ${state.stock.id}'),
                                if (state.stock.facilityId != null)
                                  Text(
                                      'Facility ID: ${state.stock.facilityId}'),
                                if (state.stock.quantity != null)
                                  Text('Quantity: ${state.stock.quantity}'),
                                if (state.stock.transactionType != null)
                                  Text(
                                      'Transaction Type: ${state.stock.transactionType}'),
                                // Add more fields similar to the searchSuccess case
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            failure: (state) => Center(
              child: Text('Error: ${state.message}'),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
// import '../blocs/stock_bloc.dart';

// class StockResultsPage extends StatelessWidget {
//   const StockResultsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Stock Results')),
//       body: BlocBuilder<StockBloc, StockState>(
//         builder: (context, state) {
//           return state.map(
//             initial: (_) =>
//                 const Center(child: Text('No search performed yet')),
//             loading: (_) => const Center(child: CircularProgressIndicator()),
//             searchSuccess: (state) {
//               if (state.stocks.isEmpty) {
//                 return const Center(child: Text('No stocks found.'));
//               }
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16.0),
//                 itemCount: state.stocks.length,
//                 itemBuilder: (context, index) {
//                   final stock = state.stocks[index];
//                   return DigitCard(
//                     padding: const EdgeInsets.all(16),
//                     margin: const EdgeInsets.only(bottom: 12),
//                     children: [
//                       Text(
//                         'Reference ID: ${stock.referenceId ?? "N/A"} (${stock.referenceIdType ?? "N/A"})',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 8),
//                       if (stock.clientReferenceId != null)
//                         Text('Client Reference ID: ${stock.clientReferenceId}'),
//                       if (stock.id != null) Text('Stock ID: ${stock.id}'),
//                       if (stock.tenantId != null)
//                         Text('Tenant ID: ${stock.tenantId}'),
//                       if (stock.facilityId != null)
//                         Text('Facility ID: ${stock.facilityId}'),
//                       if (stock.productVariantId != null)
//                         Text('Product Variant ID: ${stock.productVariantId}'),
//                       if (stock.quantity != null)
//                         Text('Quantity: ${stock.quantity}'),
//                       if (stock.transactionType != null)
//                         Text('Transaction Type: ${stock.transactionType}'),
//                       if (stock.transactionReason != null)
//                         Text('Transaction Reason: ${stock.transactionReason}'),
//                       if (stock.wayBillNumber != null)
//                         Text('Way Bill Number: ${stock.wayBillNumber}'),
//                       if (stock.transactingPartyId != null)
//                         Text(
//                             'Transacting Party ID: ${stock.transactingPartyId}'),
//                       if (stock.transactingPartyType != null)
//                         Text(
//                             'Transacting Party Type: ${stock.transactingPartyType}'),

//                       // Display additional fields if available
//                       if (stock.additionalFields?.fields != null &&
//                           stock.additionalFields!.fields!.isNotEmpty) ...[
//                         const SizedBox(height: 8),
//                         const Text('Additional Fields:',
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                         ...stock.additionalFields!.fields!
//                             .map(
//                                 (field) => Text('${field.key}: ${field.value}'))
//                             .toList(),
//                       ],

//                       // if (stock.isDeleted == true)
//                       //   const Text('Status: Deleted',
//                       //       style: TextStyle(color: Colors.red)),

//                       // if (stock.auditDetails != null) ...[
//                       //   const SizedBox(height: 8),
//                       //   const Text('Audit Details:',
//                       //       style: TextStyle(
//                       //           fontWeight: FontWeight.bold, fontSize: 14)),
//                       //   if (stock.auditDetails?.createdBy != null)
//                       //     Text('Created By: ${stock.auditDetails!.createdBy}'),
//                       //   if (stock.auditDetails?.createdTime != null)
//                       //     Text(
//                       //         'Created Time: ${_formatTimestamp(stock.auditDetails!.createdTime!)}'),
//                       //   if (stock.auditDetails?.lastModifiedBy != null)
//                       //     Text(
//                       //         'Last Modified By: ${stock.auditDetails!.lastModifiedBy}'),
//                       //   if (stock.auditDetails?.lastModifiedTime != null)
//                       //     Text(
//                       //         'Last Modified: ${_formatTimestamp(stock.auditDetails!.lastModifiedTime!)}'),
//                       // ],
//                     ],
//                   );
//                 },
//               );
//             },
//             createSuccess: (state) => Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Stock created successfully:'),
//                   const SizedBox(height: 16),
//                   DigitCard(
//                     padding: const EdgeInsets.all(16),
//                     children: [
//                       Text(
//                         'Reference ID: ${state.stock.referenceId ?? "N/A"}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 8),
//                       if (state.stock.clientReferenceId != null)
//                         Text(
//                             'Client Reference ID: ${state.stock.clientReferenceId}'),
//                       if (state.stock.id != null)
//                         Text('Stock ID: ${state.stock.id}'),
//                       if (state.stock.facilityId != null)
//                         Text('Facility ID: ${state.stock.facilityId}'),
//                       if (state.stock.quantity != null)
//                         Text('Quantity: ${state.stock.quantity}'),
//                       if (state.stock.transactionType != null)
//                         Text(
//                             'Transaction Type: ${state.stock.transactionType}'),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             failure: (state) => Center(
//               child: Text('Error: ${state.message}'),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String _formatTimestamp(int timestamp) {
//     final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
//     return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
//         '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
// import '../blocs/stock_bloc.dart';

// class StockResultsPage extends StatelessWidget {
//   const StockResultsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Stock Results')),
//       body: BlocBuilder<StockBloc, StockState>(
//         builder: (context, state) {
//           return state.map(
//             initial: (_) =>
//                 const Center(child: Text('No search performed yet')),
//             loading: (_) => const Center(child: CircularProgressIndicator()),
//             searchSuccess: (state) {
//               if (state.stocks.isEmpty) {
//                 return const Center(child: Text('No stocks found.'));
//               }
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16.0),
//                 itemCount: state.stocks.length,
//                 itemBuilder: (context, index) {
//                   final stock = state.stocks[index];
//                   return DigitCard(
//                     padding: const EdgeInsets.all(16),
//                     margin: const EdgeInsets.only(bottom: 12),
//                     children: [
//                       Text(
//                         'Stock Code: ${stock.code ?? "N/A"}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 8),
//                       if (stock.id != null) Text('Stock ID: ${stock.id}'),
//                       if (stock.tenantId != null)
//                         Text('Tenant ID: ${stock.tenantId}'),
//                       if (stock.name?.isNotEmpty ?? false)
//                         Text('Name: ${stock.name}'),
//                       if (stock.type?.isNotEmpty ?? false)
//                         Text('Type: ${stock.type}'),
//                       if (stock.quantity != null)
//                         Text('Quantity: ${stock.quantity}'),
//                       if (stock.expiryDate != null)
//                         Text(
//                             'Expiry Date: ${stock.expiryDate.toString().split(' ')[0]}'),
//                       if (stock.facility?.name?.isNotEmpty ?? false)
//                         Text('Facility: ${stock.facility!.name}'),
//                     ],
//                   );
//                 },
//               );
//             },
//             createSuccess: (state) => Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Stock created successfully:'),
//                   const SizedBox(height: 16),
//                   DigitCard(
//                     padding: const EdgeInsets.all(16),
//                     children: [
//                       Text(
//                         'Stock Code: ${state.stock.code ?? "N/A"}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 8),
//                       if (state.stock.id != null)
//                         Text('Stock ID: ${state.stock.id}'),
//                       if (state.stock.name?.isNotEmpty ?? false)
//                         Text('Name: ${state.stock.name}'),
//                       if (state.stock.type?.isNotEmpty ?? false)
//                         Text('Type: ${state.stock.type}'),
//                       if (state.stock.quantity != null)
//                         Text('Quantity: ${state.stock.quantity}'),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             failure: (state) => Center(
//               child: Text('Error: ${state.message}'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
