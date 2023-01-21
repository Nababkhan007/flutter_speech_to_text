import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_text/common/utils.dart';
import 'package:speech_text/api/speech_api.dart';
import 'package:speech_text/common/widget/substring_highlighted.dart';

class SpeechTextSection extends StatefulWidget {
  const SpeechTextSection({Key? key}) : super(key: key);

  @override
  SpeechTextSectionState createState() => SpeechTextSectionState();
}

class SpeechTextSectionState extends State<SpeechTextSection> {
  String text = "Press the button and start speaking";
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Speech to Text"),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(text);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✓   Copied to Clipboard")),
                  );
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30).copyWith(
            bottom: 150,
          ),
          child: SubstringHighlight(
            text: text,
            terms: Command.all,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            textStyleHighlight: const TextStyle(
              fontSize: 32.0,
              color: Colors.red,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 75,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            onPressed: toggleRecording,
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(const Duration(seconds: 1), () {
              Utils.scanText(text);
            });
          }
        },
      );
}
