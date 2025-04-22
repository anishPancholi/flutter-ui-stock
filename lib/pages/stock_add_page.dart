import 'package:digit_data_model/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import '../../../models/entities/stock.dart';
import '../blocs/stock_bloc.dart';
import '../../../utils/environment_config.dart';

class WarehouseApp extends StatelessWidget {
  const WarehouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse Management',
      theme: ThemeData(
        primaryColor: const Color(0xFF014354),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF014354),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFFFF7043)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            minimumSize:
                WidgetStateProperty.all(const Size(double.infinity, 50)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const WarehouseDetailsPage(), // Changed starting page
    );
  }
}

class WarehouseDetailsPage extends StatefulWidget {
  const WarehouseDetailsPage({super.key});

  @override
  _WarehouseDetailsPageState createState() => _WarehouseDetailsPageState();
}

class _WarehouseDetailsPageState extends State<WarehouseDetailsPage> {
  TextEditingController dateController = TextEditingController(
    text: "25/ 6/ 2022",
  );
  TextEditingController adminUnitController = TextEditingController(
    text: "Solimbo",
  );
  String selectedFacility = "Facility 1"; // Default value for facility dropdown

  List<String> facilities = [
    "Facility 1",
    "Facility 2",
    "Facility 3",
    "Facility 4",
    "Facility 5",
    "Facility 6",
    "Facility 7",
    "Facility 8",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: DropdownButton<String>(
          value: "Solimbo",
          dropdownColor: const Color(0xFF014354),
          style: const TextStyle(color: Colors.white),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          underline: Container(),
          onChanged: (String? newValue) {},
          items:
              <String>['Solimbo'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("Help", style: TextStyle(color: Colors.orange)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Warehouse Details",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text("Date of receipt*"),
                        TextField(
                          controller: dateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              dateController.text =
                                  "${pickedDate.day}/ ${pickedDate.month} /${pickedDate.year}";
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        const Text("Administrative unit*"),
                        TextField(
                          controller: adminUnitController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text("Facility Search Text*"),
                        GestureDetector(
                          onTap: () {
                            _showSearchFacilityDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(selectedFacility),
                                const Icon(Icons.search),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: const Text("Next"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ReceivedStockDetailsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSearchFacilityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchFacilityDialog(
          onFacilitySelected: (String facility) {
            setState(() {
              selectedFacility = facility;
            });
          },
        );
      },
    );
  }
}

class SearchFacilityDialog extends StatefulWidget {
  final Function(String) onFacilitySelected;

  const SearchFacilityDialog({super.key, required this.onFacilitySelected});

  @override
  _SearchFacilityDialogState createState() => _SearchFacilityDialogState();
}

class _SearchFacilityDialogState extends State<SearchFacilityDialog> {
  TextEditingController searchController = TextEditingController(
    text: "Facility 1",
  );
  List<String> facilities = [
    "Facility 1",
    "Facility 2",
    "Facility 3",
    "Facility 4",
    "Facility 5",
    "Facility 6",
    "Facility 7",
    "Facility 8",
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFF014354),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                  DropdownButton<String>(
                    value: "Solimbo",
                    dropdownColor: const Color(0xFF014354),
                    style: const TextStyle(color: Colors.white),
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    underline: Container(),
                    onChanged: (String? newValue) {},
                    items: <String>['Solimbo'].map<DropdownMenuItem<String>>((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Search Facility",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text("Facility Search Text"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: facilities.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(facilities[index]),
                          onTap: () {
                            widget.onFacilitySelected(facilities[index]);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReceivedStockDetailsPage extends StatefulWidget {
  const ReceivedStockDetailsPage({super.key});

  @override
  _ReceivedStockDetailsPageState createState() =>
      _ReceivedStockDetailsPageState();
}

class _ReceivedStockDetailsPageState extends State<ReceivedStockDetailsPage> {
  String? selectedProduct;
  TextEditingController receivedFromController = TextEditingController(
    text: "Provincial warehouse 1",
  );
  TextEditingController quantityController = TextEditingController();
  TextEditingController waybillController = TextEditingController();
  TextEditingController netsController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  final int balesScanned = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: DropdownButton<String>(
          value: "Solimbo",
          dropdownColor: const Color(0xFF014354),
          style: const TextStyle(color: Colors.white),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          underline: Container(),
          onChanged: (String? newValue) {},
          items:
              <String>['Solimbo'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("Help", style: TextStyle(color: Colors.orange)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Received Stock Details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text("Select product*"),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedProduct ?? ""),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text("Received from*"),
              TextField(
                controller: receivedFromController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 15),
              const Text("Quantity received*"),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              const Text("Waybill number"),
              TextField(
                controller: waybillController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              const Text("Number of nets indicated on the waybill"),
              TextField(
                controller: netsController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              const Text("Vehicle number"),
              TextField(
                controller: vehicleController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              const Text("Comments"),
              TextField(
                controller: commentsController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                maxLines: 3,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "Number of bales scanned",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$balesScanned",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text("Submit"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SuccessPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: DropdownButton<String>(
          value: "Solimbo",
          dropdownColor: const Color(0xFF014354),
          style: const TextStyle(color: Colors.white),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          underline: Container(),
          onChanged: (String? newValue) {},
          items:
              <String>['Solimbo'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  const Text(
                    "Record Created",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Successfully",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child:
                        const Icon(Icons.check, color: Colors.green, size: 32),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "The incoming stock record is created. You can view the incoming stock record in reports",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                child: const Text("Back To Home"),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
