import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatCard extends StatefulWidget {
  final width;
  final name;
  final double plan;
  final double fact;
  final double pred;
  const StatCard({
    required this.width,
    required this.name,
    required this.plan,
    required this.fact,
    required this.pred,
    super.key,
  }); // TODO: resolve possible null-safety issues

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    var width = widget.width;
    var name = widget.name;
    var plan = widget.plan;
    double fact = widget.fact;
    double pred = widget.pred;
    double factPercent = 100.0 * fact / plan;
    double predPercent = 100.0 * fact / pred;
    var factDelta = fact - plan;
    var predDelta = pred - plan;
    double maxLen = 10;

    return Container(
      //child: ConstrainedBox(
      child: Container(
        width: width,

        //constraints: BoxConstraints(maxWidth: 560, minWidth: 281),
        child: Container(
          //borderRadius: BorderRadius.circular(12),
          //color: theme.background,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          decoration: BoxDecoration(
            border: Border.all(color: theme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      //style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.onBackground,
                    ),
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: maxLen * 10,
                        child: Center(
                          child: Text(
                            'План',
                            style: GoogleFonts.inter(
                                color: theme.onBackground,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: maxLen * 10,
                        child: Center(
                          child: Text(
                            plan.toInt().toString(),
                            style: GoogleFonts.inter(
                                color: theme.onBackground,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ), // TODO: Deal with double and int
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Divider(color: theme.outline, thickness: 1.0),
                ),
                Container(
                  color: Colors.black,
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Divider(color: theme.outline, thickness: 1.0),
                ),
                CardBar(
                  mainFieldName: 'Прогноз',
                  mainField: pred,
                  delta: predDelta,
                  percent: predPercent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardBar extends StatefulWidget {
  final mainFieldName;
  final mainField;
  final percent;
  final delta;
  final state;

  const CardBar({
    this.mainFieldName,
    this.mainField,
    this.percent,
    this.delta,
    this.state,
    super.key,
  });

  @override
  State<CardBar> createState() => _CardBarState();
}

class _CardBarState extends State<CardBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    var mainFieldName = widget.mainFieldName;
    var mainField = widget.mainField;
    var factPercent = widget.percent;
    var factDelta = widget.delta;
    const colors = {
      "green": [Color(0xFFDCE7C7), Color(0xFFC7D2B2)],
      "yellow": [Color(0xFFFBEEAD), Color(0xFFF0DE84)],
      "red": [Color(0xFFFFDAD6), Color(0xFFEDBCB7)],
    };
    //var background = theme.
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
      decoration: BoxDecoration(
        //color: theme.errorContainer,
        border: Border.all(color: theme.outline, width: 1.0),
        borderRadius: BorderRadius.circular(5),
        color: colors["yellow"]![0],
      ),
      child: Stack(
        children: [
          ClipRRect(
            child: Expanded(
              child: Container(
                color: colors["green"]![1],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      mainFieldName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          //style: TextStyle(
                          color: theme.onBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${factPercent}%',
                      style: GoogleFonts.inter(
                          color: theme.onBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Text(
                    mainField.toInt().toString(),
                    style: GoogleFonts.inter(
                        color: theme.onBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Δ ${factDelta.toInt()}',
                    style: GoogleFonts.inter(
                        color: theme.onBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
