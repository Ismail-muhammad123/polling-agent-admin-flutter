import 'package:flutter/material.dart';

class PolingUnitsPage extends StatefulWidget {
  const PolingUnitsPage({super.key});

  @override
  State<PolingUnitsPage> createState() => _PolingUnitsPageState();
}

class _PolingUnitsPageState extends State<PolingUnitsPage> {
  final TextStyle _tableHeadingStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "List of Poling Units".toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        "Ward Name",
                        style: _tableHeadingStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Poling Units",
                        style: _tableHeadingStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Agent Assigned",
                        style: _tableHeadingStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Action",
                        style: _tableHeadingStyle,
                      ),
                    ),
                  ],
                  rows: [
                    ...List.generate(
                      111,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Text("Chedi"),
                          ),
                          DataCell(
                            Text("350"),
                          ),
                          DataCell(
                            Text("Ismail Muhammad"),
                          ),
                          DataCell(
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
