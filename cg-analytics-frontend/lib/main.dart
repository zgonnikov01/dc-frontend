import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:p2/pages/desktop/desktop_scaffold.dart';
import 'package:p2/pages/desktop/desktop_scaffold.dart';
import 'package:p2/pages/mobile/mobile_scaffold.dart';
import 'package:p2/pages/responsive_layout.dart';
import 'package:p2/color_schemes.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.0,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
      ),
      //darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(
        mobileScaffold: MobileScaffold(),
        desktopScaffold: DesktopScaffold(),
      ),
    );
  }
}
