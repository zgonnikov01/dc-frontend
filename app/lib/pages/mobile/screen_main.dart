import 'package:flutter/material.dart';
import 'package:p2/pages/mobile/stat_cards.dart';

import '../card_new.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  DateTime start = DateTime(2022, 01, 01);
  DateTime end = DateTime(2022, 01, 01);
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: theme.background,
      // child: GridView.count(
      //   crossAxisCount: 1,
      //   mainAxisSpacing: 10,
      //   crossAxisSpacing: 10,
      //   children: cards,
      // ),
      alignment: Alignment.topCenter,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              mainAxisExtent: 207,
              //childAspectRatio: 6 / 5,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          //padding: const EdgeInsets.all(10),
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            var e = stats.entries.toList()[index];

            final name = e.key;
            final plan = e.value['plan'];
            final pred = e.value['pred'];
            final fact = e.value['fact'];
            //final containerWidth = MediaQuery.of(context).size.width - 10; // minus paddings +spcgs
            //final cardCount = (containerWidth / (270 + 10)).floor(); // plus spacings
            //final cardWidth = containerWidth / cardCount - 11;
            //final cardWidth = cardCount == 1 ? containerWidth - 10 : 270.0;
            //print(cardWidth);
            bool state = true;
            return StatCard(
                width: 240,
                name: name,
                plan: plan!.toDouble(),
                pred: pred!.toDouble(),
                fact: fact!.toDouble(),
                state: state,
                start: start,
                end: end,
                sector: '',
                city: '',
                store: '');
          }
          //separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
    );
  }
}
