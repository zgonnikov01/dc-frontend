import 'package:flutter/material.dart';
import 'package:p2/pages/mobile/screen_main.dart';
import 'package:p2/pages/mobile/screen_rating.dart';
import 'package:p2/pages/mobile/screen_calendar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  int screenIndex = 0;
  final screens = [
    ScreenMain(),
    ScreenRating(),
    ScreenCalendar(),
  ];
  final drawers = List<Widget>.generate(
    3,
    (index) => index == 0
        ? Drawer(
            child: ListView(
              children: const [
                Text('Главная'),
                Text('Рейтинг'),
                Text('Календарь планов'),
              ],
            ),
          )
        : Drawer(),
  );
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(width.toString()),
      ),
      body: screens[screenIndex],
      drawer: drawers[screenIndex],
      // drawer: Drawer(
      //   child: ListView(
      //     children: const [
      //       Text('Главная'),
      //       Text('Рейтинг'),
      //       Text('Календарь планов'),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (screenIndex) =>
            setState(() => this.screenIndex = screenIndex),
        destinations: const [
          NavigationDestination(
            icon: Icon(PhosphorIcons.house),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIcons.trophy),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: '',
          ),
        ],
      ),
    );
  }
}
