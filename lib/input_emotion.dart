import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = "http://localhost:3000";

Map ImageLink = {
  "null": "assets/images/mean.png",
  "angry": "assets/images/angry.png",
  "anticipate": "assets/images/anticipate.png",
  "bored": "assets/images/bored.png",
  "calm": "assets/images/calm.png",
  "content": "assets/images/content.png",
  "excited": "assets/images/excited.png",
  "happy": "assets/images/happy.png",
  "relaxed": "assets/images/relaxed.png",
  "sad": "assets/images/sad.png",
  "surprised(bad reason)": "assets/images/surprised(bad).png",
  "surprised(good reason)": "assets/images/surprised(good).png",
  "tense": "assets/images/tense.png",
  "tired": "assets/images/tired.png"
};

class EmotionWrapper extends StatefulWidget {
  const EmotionWrapper(
      {Key? key, required this.setInputEmotionUp, required this.dateSelected})
      : super(key: key);
  final void Function(bool) setInputEmotionUp;
  final String dateSelected;
  @override
  State<EmotionWrapper> createState() => _EmotionWrapperState();
}

class _EmotionWrapperState extends State<EmotionWrapper> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(title: Text("", style: TextStyle(fontSize: 30))),
    // appBar: AppBar(
    //     leading: Icon(Icons.star),
    //     title: const Text("ha",
    //         textAlign: TextAlign.left,
    //         style: TextStyle(
    //           fontSize: 30,
    //           backgroundColor: Colors.blue,
    //         ))),
    // body:
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //키보드 이외의 영역 터치시 사라짐
      child: SingleChildScrollView(
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            //style 느낌
            color: Colors.white,
          ),
          child: EmotionContainer(
              date: widget.dateSelected,
              setInputEmotionUp: widget.setInputEmotionUp),
        ),
      ),
    )
        // bottomNavigationBar: BottomAppBar(
        //     child: SizedBox(
        //   height: 60,
        //   child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         IconButton(onPressed: () {}, icon: Icon(Icons.face)),
        //         IconButton(onPressed: () {}, icon: Icon(Icons.home)),
        //         IconButton(onPressed: () {}, icon: Icon(Icons.book))
        //       ]),
        // )));
        ;
  }
}

class EmotionContainer extends StatefulWidget {
  final String date;

  const EmotionContainer(
      {Key? key, required this.date, required this.setInputEmotionUp})
      : super(key: key);
  final void Function(bool) setInputEmotionUp;

  @override
  State<EmotionContainer> createState() => _EmotionContainerState();
}

class _EmotionContainerState extends State<EmotionContainer> {
  @override
  String inputText = '';
  void setInputText(String text) {
    setState(() {
      inputText = text;
    });
  }

  String emotion = "assets/images/mean.png";
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Color.fromRGBO(240, 240, 240, 1),
        ),
        child: Stack(
          children: [
            Column(children: <Widget>[
              SizedBox(height: 30),
              EmotionHead(
                  date: widget.date,
                  setInputEmotionUp: widget.setInputEmotionUp),
              SizedBox(height: 30),
              EmotionChart(emotion: emotion),
              SizedBox(
                child: Column(children: <Widget>[
                  EmotionInput(inputText: inputText, setInputText: setInputText)
                ]),
              ),
              SizedBox(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  EmotionHandleButton(
                      inputText: inputText,
                      setEmotion: setEmotion,
                      setIsLoading: setIsLoading)
                ]),
              )
            ]),
            Loading(isLoading: isLoading),
          ],
        ),
      ),
    );
  }
}

class EmotionHead extends StatefulWidget {
  const EmotionHead(
      {Key? key, required this.date, required this.setInputEmotionUp})
      : super(key: key);
  final dynamic date;
  final void Function(bool) setInputEmotionUp;

  @override
  State<EmotionHead> createState() => _EmotionHeadState();
}

class _EmotionHeadState extends State<EmotionHead> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        Opacity(
            opacity: 0,
            child: SizedBox(
              width: 60.0,
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/ico_close.png')),
            )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.date,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 60.0,
          child: IconButton(
              onPressed: () {
                widget.setInputEmotionUp(false);
              },
              icon: Image.asset('assets/images/ico_close.png')),
        )
      ]),
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
                      hintText: '오늘 OO이와의 하루는 어땠나요?',
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

class EmotionChart extends StatefulWidget {
  const EmotionChart({Key? key, required this.emotion}) : super(key: key);
  final String emotion;
  @override
  State<EmotionChart> createState() => _EmotionChartState();
}

class _EmotionChartState extends State<EmotionChart> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 80, height: 80, child: Image.asset(widget.emotion));
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
            String imageLink = ImageLink[val];
            widget.setEmotion(imageLink);
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
      height: 800,
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
