import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/radialChartData.dart';
import '../widgets/progressBar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<PieData> _pieDataList = [
    PieData("PDP", 85456),
    PieData("APC", 25654),
    PieData("NNPP", 15345),
  ];

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Results by Candidates".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
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
                    child: Icon(Icons.person),
                  ),
                ),
                Text("Ismail Muhammad"),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250,
                    width: 800,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ProgressBarWidget(
                            label: "ENGR. YUSUF ABDULLAHI AHMAD",
                            maxValue: 123450,
                            value: 85456,
                            backgroundColor: Color.fromARGB(255, 255, 172, 172),
                            progressColor: Colors.green,
                          ),
                          ProgressBarWidget(
                            label: "ENGR. SAGIR KOKI",
                            maxValue: 123450,
                            value: 25654,
                            backgroundColor: Color.fromARGB(255, 128, 255, 212),
                            progressColor: Colors.red,
                          ),
                          ProgressBarWidget(
                            label: "MUNTARI ISHAQ",
                            maxValue: 123450,
                            value: 15345,
                            backgroundColor: Color.fromARGB(255, 218, 218, 218),
                            progressColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
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
                      child: SfCircularChart(
                        title: ChartTitle(text: 'TOTAL NUMBER OF VOTES CASTED'),
                        legend: Legend(isVisible: true),
                        series: <RadialBarSeries<PieData, String>>[
                          RadialBarSeries<PieData, String>(
                            dataSource: _pieDataList,
                            trackOpacity: 0.1,
                            trackColor: Colors.grey,
                            // trackBorderWidth: 0.0,
                            // strokeWidth: 5.0,
                            strokeColor: Colors.blue,
                            xValueMapper: (PieData data, _) => data.xData,
                            yValueMapper: (PieData data, _) => data.yData,
                            dataLabelMapper: (PieData data, _) => data.text,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Collation updates".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                            style:
                                _tableHeadingStyle.copyWith(color: Colors.blue),
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.78),
                child: ListView(
                  children: List.generate(
                    20,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
        ),
      ),
    );
  }
}
