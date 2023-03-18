import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
import 'chatmessage.dart';
import 'profile.dart';

class login extends StatelessWidget {
  const login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //// title: 'Chat Together',

      theme: FlexThemeData.light(scheme: FlexScheme.custom),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepPurple),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.dark,
      home: const Login(title: 'Chat Together'),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key, required String title}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
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
                  builder: (context) => const Chat(
                        title: 'Sinfo',
                      )),
            );
          } else if (dx < 0) {
            // Swiped left
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        title: 'Sinfo',
                      )),
            );
          }
        }
      },
      child: Container(
        // margin: const EdgeInsets.all(8.5),
        padding: const EdgeInsets.all(10.5),
        color: const Color.fromARGB(31, 212, 208, 208),
        child: ListView(
          shrinkWrap: true,
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              //  color: Colors.lightBlue,
              margin: const EdgeInsets.all(8.5),
              padding: const EdgeInsets.all(5.5),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //red
                    Container(
                      margin: const EdgeInsets.all(8.5),
                      // padding: const EdgeInsets.all(10.5),
                      width: 500,
                      height: 200,
                      child: Card(
                        shape: const CircleBorder(),
                        shadowColor: Colors.blueGrey,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                ),
                                child: const Icon(Icons.person_2_rounded),
                              ),
                              const Text(
                                "Sally",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //blue
                    Card(
                      shadowColor: Colors.blueGrey,
                      child: Container(
                        // color: Colors.grey,

                        margin: const EdgeInsets.all(8.5),
                        padding: const EdgeInsets.all(8.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                prefixIcon: const Icon(Icons.person_2_rounded),
                                hintText: "username or email",
                                //icon: Icon(Icons.key_rounded),
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                hintText: "Password",
                              ),
                            ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                prefixIcon: const Icon(Icons.lock),
                                hintText: " Confirm Password",
                                //icon: Icon(Icons.key_rounded),
                              ),
                            ),
                            // const SizedBox(
                            //   height: 40,
                            // ),
                            const Text(
                                "By clickign the Register button , you agree to the public offer")
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            // const SizedBox(
            //   height: 80,
            // ),
            Card(
              child: Container(
                margin: const EdgeInsets.all(8.5),
                padding: const EdgeInsets.all(10.5),
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //grren1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(fontSize: 24),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Profile(
                                    title: 'Sinfo',
                                  ),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 40,
                    // ),

                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text("sign up with"),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 2,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // do something when button is pressed
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.g_mobiledata_rounded),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // do something when button is pressed
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.apple_rounded),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // do something when button is pressed
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.facebook),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("you dont have an account ? sign in "),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            )
            //**************************************************************************************************8 */
          ],
        ),
      ),
    ));
  }
}
