import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollingUnitForm extends StatefulWidget {
  final String? pollingUnitName, ward, pollingUnitId;
  const PollingUnitForm({
    super.key,
    this.pollingUnitName,
    this.ward,
    this.pollingUnitId,
  });

  @override
  State<PollingUnitForm> createState() => _PollingUnitFormState();
}

class _PollingUnitFormState extends State<PollingUnitForm> {
  final TextEditingController _controller = TextEditingController();

  String _editingSelectedWard = "";

  final wards = FirebaseFirestore.instance.collection('Wards').snapshots();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.pollingUnitName != null) {
      _controller.text = widget.pollingUnitName!;
    }
    _editingSelectedWard = widget.ward ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              label: Text("Polling Unit Name"),
            ),
          ),
          StreamBuilder(
              stream: wards,
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
                return SizedBox(
                  child: Row(
                    children: [
                      DropdownButton(
                        hint: const Text("Select Ward"),
                        // value: _editingSelectedWard,
                        items: snapshot.data!.docs
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.id,
                                child: Text(e.data()['name']),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => setState(
                          () {
                            _editingSelectedWard = val as String;
                          },
                        ),
                      ),
                      _editingSelectedWard.isNotEmpty
                          ? FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("Wards")
                                  .doc(_editingSelectedWard)
                                  .get(),
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
                                return Text(snapshot.data!.data()?['name']);
                              },
                            )
                          : Container(),
                    ],
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              _controller.text.isNotEmpty && _editingSelectedWard.isNotEmpty
                  ? widget.pollingUnitId == null
                      ? FirebaseFirestore.instance
                          .collection('polling_units')
                          .add({
                          "name": _controller.text,
                          "added_at": DateTime.now().toUtc().toString(),
                          "ward": _editingSelectedWard,
                        }).then((value) => Navigator.of(context).pop())
                      : FirebaseFirestore.instance
                          .collection('polling_units')
                          .doc(widget.pollingUnitId)
                          .set({
                          "name": _controller.text,
                          "added_at": DateTime.now().toUtc().toString(),
                          "ward": _editingSelectedWard,
                        }).then((value) => Navigator.of(context).pop())
                  : setState(() {});
            },
            color: Colors.green,
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
