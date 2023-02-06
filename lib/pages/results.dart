import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/reportsListTile.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final TextStyle _tableHeadingStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  final TextStyle _tableContentStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  final reportsRef =
      FirebaseFirestore.instance.collection("reports").snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Results".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            height: 80,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    "Agent Name",
                    style: _tableHeadingStyle,
                  ),
                ),
                Text(
                  "Ward",
                  style: _tableHeadingStyle,
                ),
                Text(
                  "Polling Unit",
                  style: _tableHeadingStyle,
                ),
                SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "No. Of votes Casted",
                        style: _tableHeadingStyle.copyWith(color: Colors.blue),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PDP",
                            style: _tableHeadingStyle.copyWith(
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            "APC",
                            style: _tableHeadingStyle.copyWith(
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "NNPP",
                            style: _tableHeadingStyle.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    "Result Sheet".toUpperCase(),
                    style: _tableHeadingStyle,
                  ),
                )
              ],
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: StreamBuilder(
              stream: reportsRef,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("An error has occured"),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map(
                    (e) {
                      Map<String, dynamic> data = e.data();
                      return ReportListTile(
                        agentName: data['agentName'],
                        agentEmail: data['agentEmail'],
                        agentNumber: data['agentNumber'],
                        ward: data['ward'],
                        pollingUnit: data['polling_unit'],
                        apc: data['apc'],
                        pdp: data['pdp'],
                        nnpp: data['nnpp'],
                        image: data['image'],
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
