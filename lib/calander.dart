import 'package:flutter/material.dart';

class CalanderWrapper extends StatelessWidget {
  const CalanderWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.star),
            title: const Text("ha",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  backgroundColor: Colors.blue,
                ))),
        body: SizedBox(
            height: 100,
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/emotion');
                },
                icon: Icon(Icons.add_circle))),
        bottomNavigationBar: BottomAppBar(
            child: SizedBox(
          height: 60,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(onPressed: () {}, icon: Icon(Icons.face)),
                IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                IconButton(onPressed: () {}, icon: Icon(Icons.book))
              ]),
        )));
  }
}
