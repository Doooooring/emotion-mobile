import 'package:flutter/material.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: 350,
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      hintText: 'How was your day?',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
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
