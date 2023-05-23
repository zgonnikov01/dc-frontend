import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p2/pages/desktop/login.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'desktop_screen_main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class Data {
  /// Initialize the instance of the [Data] class.
  Data({required this.x, required this.y});

  /// Spline series x points.
  final DateTime x;

  /// Spline series y points.
  final double y;
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  int screenIndex = 0;
  final screens = [
    const ScreenMain(),
    // ScreenRating(),
  ];

  final storage = const FlutterSecureStorage();

  String? token;

  Future readToken() async {
    final String? jwt = await storage.read(key: "jwt");
    token = jwt;
    log(jwt.toString());
  }

  Future logout() async {
    await storage.delete(key: 'jwt');
  }

  @override
  Widget build(BuildContext context) {
    //var w = MediaQuery.of(context).size.width;

    //DateTime _min = DateTime(2018, 01, 01);
    //DateTime _max = DateTime(2024, 01, 01);

    return FutureBuilder(
        future: readToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          } else {
            log('desktop_scaffold at line 67, token: $token');
            return token == null
                ? const LoginScreen()
                : Scaffold(
                    appBar: AppBar(
                      backgroundColor: const Color.fromARGB(255, 140, 160, 201),
                      // title: const Center(
                      //   child: Text('Цифроград аналитика'),
                      // ),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 48,
                          child: SvgPicture.asset('assets/logo_analytics.svg')
                              .animate()
                              .scale(duration: 200.ms),
                        ),
                      ),
                    ),
                    body: Row(
                      children: [
                        NavigationRail(
                          selectedIndex: screenIndex,
                          onDestinationSelected: (screenIndex) {
                            if (screenIndex == 1) {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                          title: const Text(
                                              'Вы уверены, что хотите выйти?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  logout();
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen(),
                                                    ),
                                                  );
                                                },
                                                child: const Text('Да')),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                // Navigator.pushReplacement(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             const DesktopScaffold())),
                                                child: const Text('Нет')),
                                          ]));
                            } else {
                              //setState(() => this.screenIndex = screenIndex);
                            }
                          },
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(PhosphorIcons.cards),
                              label: Text('home'),
                            ),
                            // NavigationRailDestination(
                            //   icon: Icon(PhosphorIcons.trophy),
                            //   label: Text('home1'),
                            // ),
                            NavigationRailDestination(
                              icon: Icon(PhosphorIcons.signOut),
                              label: Text('home2'),
                            ),
                          ],
                        ),
                        Expanded(
                          child: screens[screenIndex],
                        ),
                      ],
                    ),
                  );
          }
        });
  }
}
