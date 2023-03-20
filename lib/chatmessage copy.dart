import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:velocity_x/velocity_x.dart';

import 'keypads.dart';
import 'signs.dart';
import 'textspeach.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  chatScreen createState() => chatScreen();
}

class chatScreen extends State<MyHomePage> {
  TtsManager tts = TtsManager();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  late TextEditingController _controller = TextEditingController();
  // late TextEditingController keyboardControllerOne;
  //cheeks the keyboard is img or letters
  bool imgkeyboard = true;
  //names of lettrs rows
  String numbrsRow = "numbers";
  String firstRow = "first";
  String secondRow = "second";
  String thirdRow = "third";
  List<String> imges = [];
  late types.PartialText letersTyped;

//chatui
  final _user = const types.User(id: 'user');
  final _bot = const types.User(id: 'bot');

  //final List<ChatMessage> _messages = [];
  final List<types.Message> messagesList = [];
  final openAI = OpenAI.instance.build(

      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 30)),
      isLogger: true);

  void _addMessage(types.Message message) {
    setState(() {
      messagesList.insert(0, message);
    });
  }

  void sendMessage(types.PartialText message) {
    // user message
    final userTextMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );

    _addMessage(userTextMessage);

    _controller.clear();

    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": userTextMessage.text})
    ], model: kChatGptTurboModel);

    openAI.onChatCompletion(request: request).then((response) {
      Vx.log(response);

//chatbot message
      var chatGPTResponse = response!.choices[0].message.content;
      final botTextMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: chatGPTResponse,
      );

      _addMessage(botTextMessage);
      tts.speak(chatGPTResponse);
    });
  }

  // StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _initSpeech();
    // keyboardControllerOne = TextEditingController();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    //  _subscription?.cancel();
    super.dispose();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
        localeId: "ar",
        onResult: _onSpeechResult,
        listenMode: ListenMode.deviceDefault,
        partialResults: false);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _controller.text = _lastWords;
      sendMessage(types.PartialText(text: _lastWords));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Sinfo')),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(0),
                children: imges.reversed
                    .map((e) => Image.asset(
                          e,
                          width: 64,
                        ))
                    .toList(),
              ),
            ),
            Flexible(
              child: Chat(
                messages: messagesList,
                // customBottomWidget: TextField(
                //   // onTapOutside: (event) => {
                //   //   // _controller.text = _lastWords;
                //   //   // imgkeyboard = !imgkeyboard;
                //   //   // // _controller.clear();
                //   //   // // imges.clear();
                //   // },
                //   focusNode: FocusNode(
                //     canRequestFocus: false,
                //   ),
                //   autofocus: false,
                //   enabled: false,
                //   controller: _controller,
                //   decoration: InputDecoration(
                //       hintText: "enter text here",
                //       suffixIcon: ElevatedButton(
                //           onPressed: () {
                //             _controller.clear();
                //             setState(() {
                //               sendMessage(letersTyped);
                //             });
                //           },
                //           child: const Icon(
                //             Icons.send,
                //             color: Colors.black,
                //           ))),

                //   cursorColor: Colors.amber,
                //   style: TextStyle(color: Colors.black),
                // ),
                onSendPressed: sendMessage,
                emptyState: Center(
                  child: Text(
                    style: const TextStyle(color: Colors.black38),
                    // If listening is active show the recognized words
                    _speechToText.isListening
                        ? '$_lastWords'
                        // If listening isn't active but could be tell the user
                        // how to start it, otherwise indicate that speech
                        // recognition is not yet ready or not supported on
                        // the target device
                        : _speechEnabled
                            ? 'Tap the microphone to start listening...'
                            : 'Speech not available',
                  ),
                ),
                user: _user,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    //shadowColor: Colors.blueGrey,
                    // surfaceTintColor: Colors.amber,
                    //   shape:BorderRadius.circular(2.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //number Row
                        Row(
                            children: lettrsKeyboared(numbrs,
                                MediaQuery.of(context).size.width, numbrsRow)),

                        //fisrt row
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                          child: Row(
                              children: !imgkeyboard
                                  ? lettrsKeyboared(
                                      fisrtRowLetters,
                                      MediaQuery.of(context).size.width,
                                      firstRow)
                                  : signKeyboared(
                                      fisrtRowsigns,
                                      MediaQuery.of(context).size.width,
                                      firstRow)),
                        ),
                        // second row
                        Row(
                            children: !imgkeyboard
                                ? lettrsKeyboared(
                                    secondRowLetters,
                                    MediaQuery.of(context).size.width,
                                    secondRow)
                                : signKeyboared(
                                    secondRowsigns,
                                    MediaQuery.of(context).size.width,
                                    secondRow)),
                        // third row
                        Row(
                            children: !imgkeyboard
                                ? lettrsKeyboared(thirdRowLetters,
                                    MediaQuery.of(context).size.width, thirdRow)
                                : signKeyboared(
                                    thirdRowsigns,
                                    MediaQuery.of(context).size.width,
                                    thirdRow)),
                        //space row
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.text = _lastWords;
                                    imgkeyboard = !imgkeyboard;
                                    _controller.clear();
                                    imges.clear();
                                  });
                                },
                                // tooltip: 'clear',
                                child: const Icon(Icons.back_hand_rounded),
                              ),
                              Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: (() {
                                      _controller.text = "${_controller.text} ";
                                    }),
                                    icon: const Icon(Icons.space_bar_rounded),
                                    label: const Text("space")),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  _controller.text;
                                  _speechToText.isNotListening
                                      ? _startListening()
                                      : _stopListening();
                                },

                                // tooltip: 'go',
                                child: Icon(_speechToText.isNotListening
                                    ? Icons.mic_off
                                    : Icons.mic),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  _controller.clear();
                                  setState(() {
                                    _controller.clear();
                                    setState(() {
                                      sendMessage(letersTyped);
                                    });
                                  });
                                },
                                //tooltip: 'clear',
                                child: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_2_rounded),
                label: const Text("")),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search),
                label: const Text("")),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("")),
          ],
        ),
      ),
    );
  }

//***********************************************************************8 */
  List<Widget> lettrsKeyboared(
      List<String> keys, double width, String listName) {
    return keys.reversed
        .toList()
        .map((e) => Container(
              width: (width - 8) / keys.length,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.all(2.0),
              child: Material(
                child: InkWell(
                  //  splashColor: Colors.purple,
                  onTap: () {
                    _controller.text = _controller.text + e;
                    letersTyped = types.PartialText(text: _controller.text);

                    int indexofletter = keys.indexOf(e);
                    final selectedimg =
                        mappingLettrsToImgs(listName, indexofletter);

                    setState(() {
                      imges.add(selectedimg);
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Center(child: Text(e))),
                ),
              ),
            ))
        .toList();
  }

  List<Widget> signKeyboared(
          List<String> keys, double width, String listName) =>
      keys.reversed
          .map((e) => Container(
                width: (width - 8) / keys.length,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.all(2.0),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      int indexofletter = keys.indexOf(e);
                      _controller.text = _controller.text +
                          mappingImgsToLetters(listName, indexofletter);
                      letersTyped = types.PartialText(text: _controller.text);
                    },
                    child: Center(child: Image.asset(e)),
                  ),
                ),
              ))
          .toList();

  String mappingImgsToLetters(String listName, int indexofletter) {
    if (listName == "first") {
      return fisrtRowLetters[indexofletter];
    } else if (listName == "second") {
      return secondRowLetters[indexofletter];
    } else if (listName == "third") {
      return thirdRowLetters[indexofletter];
    } else if (listName == "numbers") {
      return numbrs[indexofletter];
    } else {
      return "NOT FOUND";
    }
  }

  String mappingLettrsToImgs(String listName, int indexofletter) {
    if (listName == "first") {
      return fisrtRowsigns[indexofletter];
    } else if (listName == "second") {
      return secondRowsigns[indexofletter];
    } else if (listName == "third") {
      return thirdRowsigns[indexofletter];
    } else if (listName == "numbers") {
      return numbrssigns[indexofletter];
    } else {
      return "NOT FOUND";
    }
  }
}
