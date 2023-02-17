import 'package:admin/widgets/result_list_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/raportTableHeader.dart';
import '../widgets/reportsListTile.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final TextStyle _tableHeadingStyle = const TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  final TextStyle _tableContentStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  final reportsRef =
      FirebaseFirestore.instance.collection("reports").snapshots();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                  return ResultsDataTable(
                    dataList: snapshot.data!.docs.map((e) => e.data()).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
