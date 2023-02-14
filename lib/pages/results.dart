import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/raportTableHeader.dart';
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
        const ResultTableHeader(),
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
                        // agentId: data['agentId'],
                        // agentName: data['agentName'],
                        agentEmail: data['agentEmail'],
                        // agentNumber: data['agentNumber'],
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
