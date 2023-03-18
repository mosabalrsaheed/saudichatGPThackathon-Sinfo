import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  FlutterTts flutterTts = FlutterTts();

  Future speak(String words) async {
    var result = await flutterTts.speak(words);
    //  if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stop() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
}
