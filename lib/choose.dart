import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
import 'chatmessage.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({Key? key}) : super(key: key);

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  @override
  void initState() {
    super.initState();
    _playBlindPeopleSound();
  }

  Future<void> _playBlindPeopleSound() async {
    final player = AudioPlayer();
    await player
        .play(AssetSource('blind.mp3')); // will immediately start playing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0 || details.delta.dy < 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: "",
                        )));
          }
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Chat(
                        title: 'Sinfo',
                      )));
        },
        onVerticalDragEnd: (details) {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              shape: const CircleBorder(),
              shadowColor: Colors.blueGrey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/deaf.png",
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    const Text(
                      "دعم الاعاقه السمعيه",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: const CircleBorder(),
              shadowColor: Colors.blueGrey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/blind.png",
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    const Text(
                      "دعم الاعاقه البصىية",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
