import 'package:admin/widgets/pollingUnitsForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final _pollingUnitsStream =
      FirebaseFirestore.instance.collection("polling_units").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await showDialog(
          context: context,
          builder: (context) {
            return const PollingUnitForm();
          },
        ),
        child: const Icon(Icons.add),
      ),
      body: Padding(
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
                  child: StreamBuilder(
                    stream: _pollingUnitsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                      return DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              "Polling Unit Name",
                              style: _tableHeadingStyle,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Ward",
                              style: _tableHeadingStyle,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Assigned Agent Name",
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
                        rows: snapshot.data!.docs
                            .map(
                              (e) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(e.data()['name']),
                                  ),
                                  DataCell(
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Wards')
                                          .doc(e.data()['ward'])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Text("...");
                                        }
                                        return Text(
                                            snapshot.data!.data()!['name']);
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    Text(e.data()['assigned_agent'] ??
                                        "Not assigned"),
                                  ),
                                  DataCell(
                                    IconButton(
                                      onPressed: () async => await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return PollingUnitForm(
                                            pollingUnitName: e.data()['name'],
                                            pollingUnitId: e.id,
                                            ward: e.data()['ward'],
                                          );
                                        },
                                      ),
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
