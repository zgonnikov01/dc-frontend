import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p2/pages/desktop/desktop_scaffold.dart';
import 'package:p2/pages/desktop/login.dart';

class ScreenCalendar extends StatefulWidget {
  const ScreenCalendar({super.key});

  @override
  State<ScreenCalendar> createState() => _ScreenCalendarState();
}

class _ScreenCalendarState extends State<ScreenCalendar> {
  final storage = const FlutterSecureStorage();
  Future logout() async {
    await storage.delete(key: 'jwt');
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    final theme = Theme.of(context).colorScheme;
    // return Center(
    //   child: Container(
    //     height: 300,
    //     width: 200,
    //     child: SfDateRangePicker(
    //       view: DateRangePickerView.month,
    //       selectionMode: DateRangePickerSelectionMode.extendableRange,
    //     ),
    //   ),
    // );

    return AlertDialog(
        title: const Text('Вы уверены, что хотите выйти?'),
        actions: [
          TextButton(
              onPressed: () {
                logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Да')),
          TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DesktopScaffold())),
              child: const Text('Нет')),
        ]);
  }
}
