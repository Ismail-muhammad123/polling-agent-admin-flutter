import 'package:flutter/material.dart';

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
            child: ListView(
              children: List.generate(
                20,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
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
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.person),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ahmad Isah",
                                    style: _tableContentStyle,
                                  ),
                                  Text(
                                    "09876545678",
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
                          "Chedi",
                          style: _tableContentStyle,
                        ),
                        Text(
                          "Alkantara I",
                          style: _tableContentStyle,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "600",
                                style: _tableContentStyle,
                              ),
                              Text(
                                "300",
                                style: _tableContentStyle,
                              ),
                              Text(
                                "100",
                                style: _tableContentStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Icon(
                            Icons.arrow_right,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
