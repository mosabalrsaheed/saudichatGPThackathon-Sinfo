import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
import 'chatmessage.dart';

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
      home: const Profile(title: 'Chat Together'),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key, required String title}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                        // color: Colors.yellow,
                        margin: const EdgeInsets.all(10.5),
                        padding: const EdgeInsets.all(10.5),
                        child: const Text(
                          "Create an account",
                          style: TextStyle(fontSize: 40),
                        )),
                    //blue
                    Container(
                      // color: Colors.grey,
                      //margin: const EdgeInsets.all(8.5),
                      padding: const EdgeInsets.all(8.5),
                      child: Column(
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
                          const SizedBox(
                            height: 20,
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
                          const SizedBox(
                            height: 20,
                          ),
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                              "By clickign the Register button , you agree to the public offer")
                        ],
                      ),
                    ),
                  ]),
            ),

            Container(
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
                                builder: (context) => const Chat(
                                  title: 'Sinfo',
                                ),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text("sign up with"),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
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
                        child: Icon(Icons.g_mobiledata_rounded),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // do something when button is pressed
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: Icon(Icons.apple_rounded),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // do something when button is pressed
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: Icon(Icons.facebook),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
            //**************************************************************************************************8 */
          ],
        ),
      ),
    ));
  }
}
