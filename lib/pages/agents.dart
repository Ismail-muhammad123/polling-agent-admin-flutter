import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  final _agentsStream = FirebaseFirestore.instance
      .collection('Profile')
      .where('isAgent', isEqualTo: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "List Of Agents".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.person),
                ),
              ),
              Text(FirebaseAuth.instance.currentUser?.email ?? ""),
            ],
          ),
          Flexible(
            child: StreamBuilder(
                stream: _agentsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("An error has occured"),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs
                        .map(
                          (e) => AgentListWidget(
                            fullName: e.data()['full_name'],
                            email: e.data()['email'],
                            phone: e.data()['phone_number'],
                            assignedWard: e.data()['assigned_ward'],
                            assignedPollingUnit:
                                e.data()['assigned_polling_unit'],
                          ),
                        )
                        .toList(),
                    // children: List.generate(
                    //   5,
                    //   (index) => AgentListWidget(
                    //     fullName: .,
                    //   ),
                    // ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class AgentListWidget extends StatelessWidget {
  final String fullName, phone, assignedWard, assignedPollingUnit, email;

  const AgentListWidget({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.assignedWard,
    required this.assignedPollingUnit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(20),
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: $fullName",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Email: $email",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Phone Number: $phone",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Assigned Ward:"),
                      Text(
                        assignedWard,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Assigned Poling Unit:"),
                      Text(
                        assignedPollingUnit,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // Divider(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Poling Units:"),
                  //     Text(
                  //       "80",
                  //       style: TextStyle(
                  //         color: Colors.green,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Divider(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Maximum Votes:"),
                  //     Text(
                  //       "12,000",
                  //       style: TextStyle(
                  //         color: Colors.yellow,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Result Uploaded".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('reports')
                          .where('agentEmail', isEqualTo: email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("Error"),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("PDP:"),
                                Text(snapshot.data!.docs.first['pdp']
                                    .toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("APC:"),
                                Text(snapshot.data!.docs.first['apc']
                                    .toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("NNPP:"),
                                Text(snapshot.data!.docs.first['nnpp']
                                    .toString()),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                var url = await FirebaseStorage.instance
                                    .ref()
                                    .child(snapshot.data!.docs.first['image'])
                                    .getDownloadURL();
                                // print(url);
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: const Text(
                                "view details",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
