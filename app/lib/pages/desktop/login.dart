import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:p2/pages/desktop/desktop_scaffold.dart';
import 'package:p2/api_service/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void push(r) {
    if (r != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DesktopScaffold(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD9E6F0),
      child: Center(
        child: Material(
          elevation: 30,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //border: Border.all(color: Colors.grey.shade400, width: 1)
                color: const Color(0xFFF8FBFC)),
            padding: const EdgeInsets.all(30),
            width: 350,
            child: Wrap(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/logo_analytics.svg'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      //style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        //   fillColor: Colors.white,
                        //   focusColor: Colors.blue,
                        //   hoverColor: Colors.red,
                        labelText: 'Электронная почта',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        // borderSide:
                        //     const BorderSide(color: Color(0xff92B1C8))),
                        // fillColor: Colors.white,
                        labelText: 'Пароль',
                        // labelStyle: const TextStyle(
                        //   color: Color(0xff92B1C8),
                        // ),
                      ),
                    ),
                    //ElevatedButton(onPressed: () => {}, child: Text('Войти'))
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        // TODO Divide into two functions: async and sync
                        final String email = emailController.text;
                        final String password = passwordController.text;
                        // final String? token =
                        await ApiService().getToken(email, password);
                        // storage.write(key: 'jwt', value: token);
                        // print(token);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DesktopScaffold(),
                          ),
                        );
                        //try {
                        //var r = ApiService().getCardsGraph(
                        //    '', DateTime.now(), DateTime.now(), '', '', '');
                        //await Future.delayed(Duration(milliseconds: 100));
                        //push(Desktop);
                        //  push(const DesktopScaffold());
                        //} catch (e) {
                        //  log(e.toString());
                        //}
                      },
                      child: Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xff526574),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Text(
                            'Войти',
                            style: TextStyle(color: Color(0xFFF8FBFC)),
                          ),
                        ),
                      ),
                    ),
                  ].animate().fade(duration: 300.ms).scale(duration: 300.ms),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
