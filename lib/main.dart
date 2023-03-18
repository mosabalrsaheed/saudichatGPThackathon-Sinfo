import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'choose.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //// title: 'Chat Together',

      theme: FlexThemeData.light(scheme: FlexScheme.custom),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepPurple),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.dark,
      home: const Logo(title: 'Chat Together'),
    );
  }
}

class Logo extends StatefulWidget {
  const Logo({Key? key, required String title}) : super(key: key);

  @override
  State<Logo> createState() => LogoState();
}

class LogoState extends State<Logo> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() async {
    ///wait for 3 seconds then go to login page
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChoosePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  // Only detect horizontal swipes5
                  if (details.delta.dx.abs() > details.delta.dy.abs()) {
                    // Calculate the difference between the current position and the starting position
                    double dx = details.delta.dx;

                    // Use the difference to determine whether the user swiped left or right
                    if (dx > 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Logo(
                                  title: 'Sinfo',
                                )),
                      );
                    } else if (dx < 0) {
                      // Swiped left
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login(
                                  title: 'Sinfo',
                                )),
                      );
                    }
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FadeInImage(
                      placeholder: AssetImage("assets/sinfo.png"),
                      image: AssetImage("assets/sinfo.png"),
                      fadeOutDuration: Duration(milliseconds: 300),
                      fadeInDuration: Duration(milliseconds: 800),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
