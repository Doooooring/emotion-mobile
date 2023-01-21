import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = "http://localhost:3000";

class EmotionContainer extends StatefulWidget {
  const EmotionContainer({Key? key}) : super(key: key);

  @override
  State<EmotionContainer> createState() => _EmotionContainerState();
}

class _EmotionContainerState extends State<EmotionContainer> {
  String inputText = '';
  void setInputText(String text) {
    setState(() {
      inputText = text;
    });
  }

  String emotion = "";
  void setEmotion(String newEmotion) {
    setState(() {
      emotion = newEmotion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        EmotionInput(inputText: inputText, setInputText: setInputText)
      ]),
      EmotionChart(emotion: emotion),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        EmotionHandleButton(inputText: inputText, setEmotion: setEmotion)
      ])
    ]);
  }
}

class EmotionInput extends StatefulWidget {
  const EmotionInput(
      {Key? key, required this.inputText, required this.setInputText})
      : super(key: key);
  final String inputText;
  final void Function(String) setInputText;
  @override
  State<EmotionInput> createState() => _EmotionInputState();
}

class _EmotionInputState extends State<EmotionInput> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextField(
        onChanged: (text) {
          widget.setInputText(text);
        },
        keyboardType: TextInputType.multiline,
        maxLines: 3,
      )
    ]);
  }
}

class EmotionChart extends StatefulWidget {
  const EmotionChart({Key? key, required this.emotion}) : super(key: key);
  final String emotion;
  @override
  State<EmotionChart> createState() => _EmotionChartState();
}

class _EmotionChartState extends State<EmotionChart> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class EmotionHandleButton extends StatefulWidget {
  const EmotionHandleButton(
      {Key? key, required this.inputText, required this.setEmotion})
      : super(key: key);
  final String inputText;
  final void Function(String) setEmotion;
  @override
  State<EmotionHandleButton> createState() => _EmotionHandleButtonState();
}

Future<String> getEmotion(String text) async {
  Uri endPoint = Uri.parse('$url/emotion');
  http.Response response = await http.post(endPoint, body: {text: text});
  String emotion = jsonDecode(response.body);
  return emotion;
}

class _EmotionHandleButtonState extends State<EmotionHandleButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.send),
        onPressed: () {
          Future<String> emotion = getEmotion(widget.inputText);
          emotion.then((val) {
            widget.setEmotion(val);
          });
        });
  }
}
