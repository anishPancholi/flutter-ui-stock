import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import '../../../pages/stock_results_page.dart';
// Add this import
import '../../../models/entities/stock.dart';
import '../blocs/stock_bloc.dart';
import '../../../utils/environment_config.dart';
import '../router/app_router.dart';
// import 'stock_entry_page.dart';
import 'delete.dart';

@RoutePage()
class StockSamplePage extends StatefulWidget {
  const StockSamplePage({super.key});

  @override
  State<StockSamplePage> createState() => _StockSamplePageState();
}

class _StockSamplePageState extends State<StockSamplePage> {
  final TextEditingController _clientRefIdController = TextEditingController();
  String _searchType = 'clientReference';
  bool _hasNavigatedToResultsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Management'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// Search input + buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DigitCard(
                padding: const EdgeInsets.all(16),
                children: [
                  // Radio buttons for search type
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Search by Client Reference ID'),
                          value: 'clientReference',
                          groupValue: _searchType,
                          onChanged: (value) {
                            setState(() {
                              _searchType = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  // Show appropriate search field based on selection
                  if (_searchType == 'clientReference')
                    LabeledField(
                      label: 'Client Reference ID',
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DigitTextFormInput(
                              controller: _clientRefIdController,
                              onChange: (value) {
                                // We'll use the controller value directly
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                        ),
                        onPressed: () {
                          // Check if the relevant controller has a value
                          final clientRefId =
                              _clientRefIdController.text.trim();

                          if (_searchType == 'clientReference' &&
                              clientRefId.isEmpty) return;

                          context.read<StockBloc>().add(
                                StockEvent.search(
                                  query: StockSearchModel(
                                    tenantId: envConfig.variables.tenantId,
                                    clientReferenceId:
                                        _searchType == 'clientReference'
                                            ? [clientRefId]
                                            : null,
                                  ),
                                ),
                              );
                          setState(() {
                            _hasNavigatedToResultsPage = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StockResultsPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                        ),
                        onPressed: () {
                          context.read<StockBloc>().add(
                                StockEvent.search(
                                  query: StockSearchModel(
                                    tenantId: envConfig.variables.tenantId,
                                  ),
                                ),
                              );
                          setState(() {
                            _hasNavigatedToResultsPage = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StockResultsPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Load All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Add spacing between button rows
                  const SizedBox(height: 16),

                  // Create button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WarehouseDetailsPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create New Stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            /// Stock List (disabled after navigation)
            _hasNavigatedToResultsPage
                ? const SizedBox.shrink()
                : BlocBuilder<StockBloc, StockState>(
                    builder: (context, state) {
                      return state.map(
                        initial: (_) => const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                              'Press "Search" or "Load All" to view stocks'),
                        ),
                        loading: (_) => const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        searchSuccess: (state) {
                          if (state.stocks.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No stocks found.'),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Search Again'),
                            );
                          }
                        },
                        createSuccess: (_) => const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Stock created successfully.'),
                        ),
                        failure: (state) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Error: ${state.message}'),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:digit_ui_components/digit_components.dart';
// import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
// import '../../../pages/stock_results_page.dart';
// import '../../../models/entities/stock.dart';
// import '../blocs/stock_bloc.dart';
// import '../../../utils/environment_config.dart';
// import '../router/app_router.dart';

// @RoutePage()
// class StockSamplePage extends StatefulWidget {
//   const StockSamplePage({super.key});

//   @override
//   State<StockSamplePage> createState() => _StockSamplePageState();
// }

// class _StockSamplePageState extends State<StockSamplePage> {
//   final TextEditingController _clientRefIdController = TextEditingController();
//   //final TextEditingController _referenceIdController = TextEditingController();
//   String _searchType = 'clientReference'; // 'clientReference' or 'reference'
//   bool _hasNavigatedToResultsPage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stock Management'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 16),

//             /// Search input + buttons
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: DigitCard(
//                 padding: const EdgeInsets.all(16),
//                 children: [
//                   // Radio buttons for search type
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RadioListTile<String>(
//                           title: const Text('Search by Client Reference ID'),
//                           value: 'clientReference',
//                           groupValue: _searchType,
//                           onChanged: (value) {
//                             setState(() {
//                               _searchType = value!;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Show appropriate search field based on selection
//                   if (_searchType == 'clientReference')
//                     LabeledField(
//                       label: 'Client Reference ID',
//                       child: Row(
//                         children: [
//                           const Icon(Icons.search),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: DigitTextFormInput(
//                               controller: _clientRefIdController,
//                               onChange: (value) {
//                                 // We'll use the controller value directly
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepOrange,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 14, horizontal: 24),
//                         ),
//                         onPressed: () {
//                           // Check if the relevant controller has a value
//                           final clientRefId =
//                               _clientRefIdController.text.trim();

//                           if (_searchType == 'clientReference' &&
//                               clientRefId.isEmpty) return;

//                           context.read<StockBloc>().add(
//                                 StockEvent.search(
//                                   query: StockSearchModel(
//                                     tenantId: envConfig.variables.tenantId,
//                                     clientReferenceId:
//                                         _searchType == 'clientReference'
//                                             ? [clientRefId]
//                                             : null,
//                                     // referenceId: _searchType == 'reference'
//                                     //     ? referenceId
//                                     //     : null,
//                                   ),
//                                 ),
//                               );
//                           setState(() {
//                             _hasNavigatedToResultsPage = true;
//                           });
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const StockResultsPage(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           'Search',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.grey,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 14, horizontal: 24),
//                         ),
//                         onPressed: () {
//                           context.read<StockBloc>().add(
//                                 StockEvent.search(
//                                   query: StockSearchModel(
//                                     tenantId: envConfig.variables.tenantId,
//                                   ),
//                                 ),
//                               );
//                           setState(() {
//                             _hasNavigatedToResultsPage = true;
//                           });
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const StockResultsPage(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           'Load All',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),

//             /// Stock List (disabled after navigation)
//             _hasNavigatedToResultsPage
//                 ? const SizedBox.shrink()
//                 : BlocBuilder<StockBloc, StockState>(
//                     builder: (context, state) {
//                       return state.map(
//                         initial: (_) => const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                               'Press "Search" or "Load All" to view stocks'),
//                         ),
//                         loading: (_) => const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Center(child: CircularProgressIndicator()),
//                         ),
//                         searchSuccess: (state) {
//                           if (state.stocks.isEmpty) {
//                             return const Padding(
//                               padding: EdgeInsets.all(16.0),
//                               child: Text('No stocks found.'),
//                             );
//                           } else {
//                             return const Padding(
//                               padding: EdgeInsets.all(16.0),
//                               child: Text('Search Again'),
//                             );
//                           }

//                         },
//                         createSuccess: (_) => const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text('Stock created successfully.'),
//                         ),
//                         failure: (state) => Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Text('Error: ${state.message}'),
//                         ),
//                       );
//                     },
//                   ),
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }







// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Import your model and repository files.
// import '../../../models/entities/stock.dart'; // Your stock model and mappers
// import '../../../data/repositories/remote/stock.dart'; // Your repository
// import '../../../blocs/stock_bloc.dart'; // The file containing StockBloc, StockEvent, StockState (Freezed based)

// import 'package:auto_route/auto_route.dart'; // Import for RoutePage annotation

// @RoutePage()
// class StockPageFreezed extends StatefulWidget {
//   const StockPageFreezed({Key? key}) : super(key: key);

//   @override
//   _StockPageFreezedState createState() => _StockPageFreezedState();
// }

// class _StockPageFreezedState extends State<StockPageFreezed> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 1. Create and configure your Dio instance.
//     final dio = Dio();

//     // 2. Instantiate your repository using the Dio instance.
//     final stockRepository = StockRepository(dio);

//     return BlocProvider(
//       // 3. Provide the StockBloc, injecting the repository.
//       create: (_) => StockBloc(stockRepository),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Stock Management - Freezed Bloc')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // TextField to input search keyword.
//               TextField(
//                 controller: _searchController,
//                 decoration: const InputDecoration(
//                   labelText: 'Enter search keyword',
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Row with two buttons: one for searching stocks, one for creating a new stock.
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       // Create a StockSearchModel using the entered keyword.
//                       final query = StockSearchModel(
//                         id: _searchController.text,
//                         // Populate additional fields if necessary.
//                       );
//                       // Dispatch the search event.
//                       context
//                           .read<StockBloc>()
//                           .add(StockEvent.search(query: query));
//                     },
//                     child: const Text('Search Stock'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Create a StockModel for the new stock entry.
//                       final model = StockModel(
//                         clientReferenceId: 'sample_ref', // sample data
//                         // Populate additional fields if necessary.
//                       );
//                       // Dispatch the create event.
//                       context
//                           .read<StockBloc>()
//                           .add(StockEvent.create(model: model));
//                     },
//                     child: const Text('Create Stock'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               // BlocBuilder listens to the StockBloc and rebuilds the UI based on its state.
//               Expanded(
//                 child: BlocBuilder<StockBloc, StockState>(
//                   builder: (context, state) {
//                     return state.when(
//                       initial: () => const Center(
//                         child: Text('Please search or create a stock.'),
//                       ),
//                       loading: () =>
//                           const Center(child: CircularProgressIndicator()),
//                       searchSuccess: (stocks) => ListView.builder(
//                         itemCount: stocks.length,
//                         itemBuilder: (context, index) {
//                           final stock = stocks[index];
//                           return ListTile(
//                             title: Text(stock.clientReferenceId),
//                             subtitle: Text('ID: ${stock.id ?? "N/A"}'),
//                           );
//                         },
//                       ),
//                       createSuccess: (stock) => Center(
//                         child: Text(
//                           'Created Stock: ${stock.clientReferenceId}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       failure: (message) => Center(
//                         child: Text(
//                           'Error: $message',
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auto_route/auto_route.dart';

// import '../../../models/entities/stock.dart';
// import '../../../data/repositories/remote/stock.dart';
// import '../../../blocs/stock_bloc.dart';

// @RoutePage()
// class StockSamplePage extends StatelessWidget {
//   const StockSamplePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Provide Dio and StockRepository only once at the top
//     return BlocProvider(
//       create: (_) => StockBloc(StockRepository(Dio())),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Stock Sample Page'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 16),

//               /// 🔍 Search Button
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<StockBloc>().add(
//                         StockEvent.search(
//                           query: StockSearchModel(tenantId: 'mz'),
//                         ),
//                       );
//                 },
//                 child: const Text('Load Stocks'),
//               ),

//               /// 📦 Stock List Renderer
//               BlocBuilder<StockBloc, StockState>(
//                 builder: (context, state) {
//                   return state.when(
//                     initial: () => const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Text('Press the button to load stocks'),
//                     ),
//                     loading: () => const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: CircularProgressIndicator(),
//                     ),
//                     searchSuccess: (stocks) => ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: stocks.length,
//                       itemBuilder: (context, index) {
//                         final stock = stocks[index];
//                         return ListTile(
//                           title: Text(stock.clientReferenceId),
//                           subtitle: Text('ID: ${stock.id ?? "No ID"}'),
//                         );
//                       },
//                     ),
//                     createSuccess: (stock) => Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'Created Stock: ${stock.clientReferenceId}',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     failure: (message) => Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'Error: $message',
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   );
//                 },
//               ),

//               const Divider(height: 32),

//               /// ➕ Create Button
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<StockBloc>().add(
//                         StockEvent.create(
//                           model: StockModel(
//                             clientReferenceId: 'sample_create_ref',
//                             tenantId: 'mz',
//                           ),
//                         ),
//                       );
//                 },
//                 child: const Text('Create Stock'),
//               ),

//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// @RoutePage()
// class StockSamplePage extends StatelessWidget {
//   const StockSamplePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stock Sample Page'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// 🔍 Search Section
//             const Text(
//               'Search Stocks:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<StockBloc>().add(
//                           StockEvent.search(
//                             query: StockSearchModel(tenantId: 'mz'),
//                           ),
//                         );
//                   },
//                   child: const Text('🔍 Load Stocks'),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Click to fetch stocks for tenant "mz"',
//                   softWrap: true,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 8),

//             /// 🧾 Result of Search or Error
//             BlocBuilder<StockBloc, StockState>(
//               builder: (context, state) {
//                 return state.maybeWhen(
//                     orElse: () => Text('Initial Or Laod'),
//                     searchSuccess: (stocks) =>
//                         Text(stocks.first.id ?? 'No ID'));
//                 // state.when(
//                 //   initial: () => const Padding(
//                 //     padding: EdgeInsets.only(top: 16.0),
//                 //     child: Text('Press the button to load stocks'),
//                 //   ),
//                 //   loading: () => const Padding(
//                 //     padding: EdgeInsets.all(16.0),
//                 //     child: CircularProgressIndicator(
//                 //       backgroundColor: Colors.red,
//                 //     ),
//                 //   ),
//                 //   searchSuccess: (stocks) => Text(stocks.first.id ?? 'No ID'),
//                 //   createSuccess: (_) => const SizedBox.shrink(),
//                 //   failure: (message) => Padding(
//                 //     padding: const EdgeInsets.only(top: 16.0),
//                 //     child: Text(
//                 //       '❌ Error: $message',
//                 //       style: const TextStyle(color: Colors.red),
//                 //     ),
//                 //   ),
//                 // );
//               },
//             ),

//             const Divider(height: 40),

//             /// ➕ Create Section
//             const Text(
//               'Create New Stock:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<StockBloc>().add(
//                           StockEvent.create(
//                             model: StockModel(
//                               clientReferenceId: 'sample_create_ref',
//                               tenantId: 'mz',
//                             ),
//                           ),
//                         );
//                   },
//                   child: const Text('➕ Create Stock'),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Creates a stock with reference `sample_create_ref`',
//                   softWrap: true,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 8),

//             /// ✅ Created message
//             BlocBuilder<StockBloc, StockState>(
//               builder: (context, state) {
//                 return state.maybeWhen(
//                   createSuccess: (stock) => Padding(
//                     padding: const EdgeInsets.only(top: 16.0),
//                     child: Text(
//                       '✅ Created Stock: ${stock.clientReferenceId}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                   orElse: () => const SizedBox.shrink(),
//                 );
//               },
//             ),
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }
