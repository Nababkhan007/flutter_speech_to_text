import 'package:flutter/material.dart';
import 'package:speech_text/view/speech_text_view.dart';

void main() => runApp(const SpeechToText());

class SpeechToText extends StatelessWidget {
  const SpeechToText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SpeechTextView(),
    );
  }
}
