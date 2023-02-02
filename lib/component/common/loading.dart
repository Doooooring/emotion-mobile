import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key, required this.isLoading, required this.height})
      : super(key: key);
  final bool isLoading;
  final double height;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
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
