import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Speech to Text"),
        ),
      ),
    );
  }
}
