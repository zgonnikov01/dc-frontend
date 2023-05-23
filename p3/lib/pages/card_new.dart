import 'dart:math';

import 'package:flutter/material.dart';
import 'package:p2/api_service/api_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p2/api_service/api_service_models.dart';

class StatCard extends StatefulWidget {
  const StatCard(
      {super.key,
      required this.plan,
      required this.fact,
      required this.pred,
      required this.width,
      required this.name,
      required this.state,
      required this.start,
      required this.end,
      required this.sector,
      required this.city,
      required this.store});

  final double plan;
  final double fact;
  final double pred;
  final double width;
  final String name;
  final bool state;
  final DateTime start;
  final DateTime end;
  final String sector;
  final String city;
  final String store;

  @override
  State<StatCard> createState() => _CardState();
}

class _GraphData {
  _GraphData(this.date, this.fact);

  final String date;
  final int fact;
}

class _CardState extends State<StatCard> {
  late CardGraphDataModel _graph;
  late DateTime start;
  late DateTime end;
  late List<_GraphData> data;
  late String sector;
  late String city;
  late String store;

  @override
  void initState() {
    super.initState();
    start = widget.start;
    end = widget.end;
    sector = widget.sector;
    city = widget.city;
    store = widget.store;
    _getGraph();
  }

  void _getGraph() async {
    _graph = (await ApiService()
        .getCardsGraph(widget.name, start, end, sector, city, store))!;
    // Future.delayed(const Duration(milliseconds: 100))
    //     .then((value) => setState(() {}));
    data = List<_GraphData>.generate(_graph.dates.length,
        (index) => _GraphData(_graph.dates[index], _graph.fact[index]));
  }

  bool cardStateDefault = true;
  doSomething() {
    if (cardStateDefault) {
      _getGraph();
    }
    setState(() {
      cardStateDefault = !cardStateDefault;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    double plan = widget.plan;
    String name = widget.name;
    double fact = widget.fact;
    double pred = widget.pred;
    double scale = 1;
    //DateTime start = widget.start;
    //DateTime end = widget.end;

    var numberFormat = NumberFormat(",###", "ru-RU");

    return Column(
      children: [
        GestureDetector(
          // When the child is tapped, show a snackbar.
          onTap: () {
            doSomething();
          },
          child: SizedBox(
            width: widget.width,
            //height: 230,
            //padding: const EdgeInsets.all(15),
            child: Container(
              //padding: const EdgeInsets.all(10),
              //color: theme.background,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              decoration: BoxDecoration(
                border: Border.all(color: theme.outline, width: 1.0),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              //alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16)), //TODO

                  !cardStateDefault
                      ? Container(
                          height: 170,
                          padding: const EdgeInsets.only(right: 10),
                          //Initialize the chart widget
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              //title: ChartTitle(
                              //    text: 'Half yearly sales analysis'),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<_GraphData, String>>[
                                LineSeries<_GraphData, String>(
                                    dataSource: data,
                                    xValueMapper: (_GraphData sales, _) =>
                                        sales.date,
                                    yValueMapper: (_GraphData sales, _) =>
                                        sales.fact,
                                    name: 'Sales',
                                    // Enable data label
                                    dataLabelSettings:
                                        const DataLabelSettings(isVisible: false))
                              ]),
                        )
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     //Initialize the spark charts widget
                      //     child: SfSparkLineChart.custom(
                      //       //Enable the trackball
                      //       trackball: SparkChartTrackball(
                      //           activationMode:
                      //               SparkChartActivationMode.tap),
                      //       //Enable marker
                      //       marker: SparkChartMarker(
                      //           displayMode:
                      //               SparkChartMarkerDisplayMode.all),
                      //       //Enable data label
                      //       labelDisplayMode:
                      //           SparkChartLabelDisplayMode.all,
                      //       xValueMapper: (int index) => data[index].year,
                      //       yValueMapper: (int index) =>
                      //           data[index].sales,
                      //       dataCount: 5,
                      //     ),
                      //   ),
                      // )
                      //]))
                      : Stack(
                          children: [
                            Column(
                              children: [
                                Container(height: 30 * scale),
                                Divider(color: theme.outline, thickness: 1.0),
                                Bar(
                                    percent: 100.0 * fact / plan,
                                    theme: theme,
                                    scale: scale),
                                Divider(color: theme.outline, thickness: 1.0),
                                Bar(
                                    percent: 100.0 * pred / plan,
                                    theme: theme,
                                    scale: scale),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 38 * scale,
                                          child: const Center(
                                              child: Text(
                                            "План",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )),
                                        ),
                                        //
                                        SizedBox(
                                          height: 66 * scale,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Факт",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                '${(100.0 * fact / plan).toStringAsFixed(2)}%',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 66 * scale,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Прогноз",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                '${(100.0 * pred / plan).toStringAsFixed(2)}%',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                  Column(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height: 38 * scale,
                                            child: Center(
                                              child: Text(
                                                  numberFormat.format(plan)),
                                            )),
                                        //
                                        SizedBox(
                                          height: 66 * scale,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(numberFormat.format(fact)),
                                              Row(children: [
                                                SvgPicture.asset(
                                                  (fact / plan >= 0.9)
                                                      ? 'assets/Delta_green.svg'
                                                      : 'assets/Delta_blue.svg',
                                                ),
                                                Text(
                                                    ' ${numberFormat.format(fact - plan)}'),
                                              ]),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 66 * scale,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(numberFormat.format(pred)),
                                              Row(children: [
                                                SvgPicture.asset(
                                                  (pred / plan >= 0.9)
                                                      ? 'assets/Delta_green.svg'
                                                      : 'assets/Delta_blue.svg',
                                                ),
                                                Text(
                                                    ' ${numberFormat.format(pred - plan)}'),
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Bar extends StatefulWidget {
  const Bar({
    super.key,
    required this.percent,
    required this.theme,
    required this.scale,
  });

  final ColorScheme theme;
  final double percent;
  final double scale;

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    double percent = widget.percent;

    const List<List<Color>> colors_all = [
      [
        Color(0xFFEAF5FF),
        Color(0xFF7EAAFF),
        Color(0xFFB7C7FF),
        Color(0xFFD3D5FF)
      ],
      [
        Color(0xFFF5FFE1),
        Color(0xFF4DFF8D),
        Color(0xFF6AFFA0),
        Color(0xFFCCF8C5)
      ],
    ];

    List<Color> colors = colors_all[0];
    if (percent >= 90) colors = colors_all[1];

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: widget.theme.outline, width: 1.0),
        borderRadius: BorderRadius.circular(5),
        color: colors[0],
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(2.5),
        child: FractionallySizedBox(
          widthFactor: min(percent, 100) / 100,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.0, 0.5, 0.9],
                colors: <Color>[colors[1], colors[2], colors[3]],
                tileMode: TileMode.mirror,
              ),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(4),
                topRight: percent > 99.3 ? const Radius.circular(4) : Radius.zero,
                bottomLeft: const Radius.circular(4),
                bottomRight: percent > 99.3 ? const Radius.circular(4) : Radius.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
