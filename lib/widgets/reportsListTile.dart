import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';



import 'package:url_launcher/url_launcher.dart';class ReportListTile extends StatelessWidget {
  final String agentName, agentEmail, agentNumber, ward, pollingUnit, image;
  final double pdp, apc, nnpp;

  final TextStyle tableContentStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  const ReportListTile({
    required this.agentName,
    required this.agentEmail,
    required this.agentNumber,
    required this.ward,
    required this.pollingUnit,
    required this.image,
    required this.apc,
    required this.pdp,
    required this.nnpp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.person),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        agentName,
                        style: tableContentStyle,
                      ),
                      Text(
                        agentNumber,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              ward,
              style: tableContentStyle,
            ),
            Text(
              pollingUnit,
              style: tableContentStyle,
            ),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    pdp.toString(),
                    style: tableContentStyle,
                  ),
                  Text(
                    apc.toString(),
                    style: tableContentStyle,
                  ),
                  Text(
                    nnpp.toString(),
                    style: tableContentStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () async {
                  var url = await FirebaseStorage.instance
                      .ref()
                      .child(image)
                      .getDownloadURL();
                  // print(url);
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    Icon(
                      Icons.arrow_right,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
