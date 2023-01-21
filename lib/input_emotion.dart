import 'dart:convert';
import 'dart:developer' as developer;

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

  String emotion = "Nothing";
  void setEmotion(String newEmotion) {
    setState(() {
      emotion = newEmotion;
    });
  }

  bool isLoading = true;
  void setIsLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(children: <Widget>[
          EmotionChart(emotion: emotion),
          SizedBox(
            child: Column(children: <Widget>[
              EmotionInput(inputText: inputText, setInputText: setInputText)
            ]),
          ),
          SizedBox(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              EmotionHandleButton(
                  inputText: inputText,
                  setEmotion: setEmotion,
                  setIsLoading: setIsLoading)
            ]),
          )
        ]),
        Loading(isLoading: isLoading),
        TextButton(
          onPressed: () {
            setIsLoading(!isLoading);
            if (isLoading) {
              developer.log("hi");
            } else {
              developer.log("no");
            }
          },
          child: Text("here"),
        )
      ],
    );
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
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: 350,
                child: TextField(
                  decoration: const InputDecoration(
                      labelText: 'Todays..',
                      hintText: 'Text your daily here',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.blueGrey))),
                  onChanged: (text) {
                    widget.setInputText(text);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 9,
                ),
              ),
            )
          ],
        ));
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
    return Container(width: 60, height: 50, child: Text(widget.emotion));
  }
}

class EmotionHandleButton extends StatefulWidget {
  const EmotionHandleButton(
      {Key? key,
      required this.inputText,
      required this.setEmotion,
      required this.setIsLoading})
      : super(key: key);
  final String inputText;
  final void Function(String) setEmotion;
  final void Function(bool) setIsLoading;
  @override
  State<EmotionHandleButton> createState() => _EmotionHandleButtonState();
}

Future<String> getEmotion(String text) async {
  Uri endPoint = Uri.parse('$url/emotion');
  var bodyEncoded = json.encode({"text": text});
  http.Response response = await http.post(endPoint,
      body: bodyEncoded, headers: {"Content-Type": "application/json"});
  dynamic result = json.decode(response.body);
  String emotion = result["emotion"];
  return emotion;
}

class _EmotionHandleButtonState extends State<EmotionHandleButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.send),
        onPressed: () {
          widget.setIsLoading(false);
          Future<String> emotion = getEmotion(widget.inputText);
          emotion.then((val) {
            developer.log(val);
            widget.setEmotion(val);
            widget.setIsLoading(true);
          });
        });
  }
}

class Loading extends StatefulWidget {
  const Loading({Key? key, required this.isLoading}) : super(key: key);
  final bool isLoading;
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Offstage(
          offstage: widget.isLoading,
          child: Stack(children: const <Widget>[
            Opacity(
              opacity: 0.5,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
            Center(child: CircularProgressIndicator())
          ])),
    );
  }
}
