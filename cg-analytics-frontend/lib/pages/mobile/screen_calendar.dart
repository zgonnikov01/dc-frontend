import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ScreenCalendar extends StatefulWidget {
  const ScreenCalendar({super.key});

  @override
  State<ScreenCalendar> createState() => _ScreenCalendarState();
}

class _ScreenCalendarState extends State<ScreenCalendar> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    final theme = Theme.of(context).colorScheme;
    return Card(plan: 47847123, fact: 26867469, pred: 44224325);
  }
}

class Card extends StatefulWidget {
  const Card({
    super.key,
    required this.plan,
    required this.fact,
    required this.pred,
  });

  final double plan;
  final double fact;
  final double pred;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    double plan = widget.plan;
    double fact = widget.fact;
    double pred = widget.pred;
    var numberFormat = NumberFormat(",###", "ru-RU");
    return Column(
      children: [
        Container(
          width: 300,
          //height: 230,
          padding: const EdgeInsets.all(15),
          child: Container(
            //padding: const EdgeInsets.all(10),
            //color: theme.background,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            decoration: BoxDecoration(
              border: Border.all(color: theme.outline, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            //alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Text("Моб. Телефоны"), //TODO
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(height: 30),
                        Divider(color: theme.outline, thickness: 1.0),
                        Bar(percent: 100.0 * fact / plan, theme: theme),
                        Divider(color: theme.outline, thickness: 1.0),
                        Bar(percent: 100.0 * pred / plan, theme: theme),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 38,
                                  child: const Center(child: Text("План")),
                                ),
                                //
                                Container(
                                  height: 66,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Факт"),
                                      Text(
                                          '${(100.0 * fact / plan).toStringAsFixed(2)}%'),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 66,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Прогноз"),
                                      Text(
                                          '${(100.0 * pred / plan).toStringAsFixed(2)}%'),
                                    ],
                                  ),
                                ),
                              ]),
                          Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 38,
                                    child: Center(
                                      child: Text(numberFormat.format(plan)),
                                    )),
                                //
                                Container(
                                  height: 66,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(numberFormat.format(fact)),
                                      Text("Δ 799 085"),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 66,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(numberFormat.format(pred)),
                                      Text("Δ 799 085"),
                                    ],
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    )
                  ],
                ),
              ],
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
  });

  final ColorScheme theme;
  final double percent;

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    double percent = widget.percent;
    const colors = {
      "green": [Color(0xFFDCE7C7), Color(0xFFC7D2B2)],
      "yellow": [Color(0xFFFBEEAD), Color(0xFFF0DE84)],
      "red": [Color(0xFFFFDAD6), Color(0xFFEDBCB7)],
    };

    String color = "red";
    if (percent >= 90) color = "yellow";
    if (percent >= 100) color = "green";

    Color light_color = colors[color]![0];
    Color dark_color = colors[color]![1];

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: widget.theme.outline, width: 1.0),
        borderRadius: BorderRadius.circular(5),
        color: light_color,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(3.5),
        child: FractionallySizedBox(
          widthFactor: min(percent, 100) / 100,
          child: Container(
            decoration: BoxDecoration(
              color: dark_color,
              //borderRadius: BorderRadius.circular(5),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(4),
                topRight: percent > 99.3 ? Radius.circular(4) : Radius.zero,
                bottomLeft: const Radius.circular(4),
                bottomRight: percent > 99.3 ? Radius.circular(4) : Radius.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
