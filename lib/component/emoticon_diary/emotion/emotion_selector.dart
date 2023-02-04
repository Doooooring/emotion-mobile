import 'dart:ui';

import 'package:flutter/material.dart';

class EmoticonSelector extends StatefulWidget {
  const EmoticonSelector(
      {Key? key,
      required this.emotionSelectorUp,
      required this.id,
      required this.date,
      required this.emotion})
      : super(key: key);
  final bool emotionSelectorUp;
  final String? id;
  final DateTime date;
  final String? emotion;

  @override
  State<EmoticonSelector> createState() => _EmoticonSelectorState();
}

class _EmoticonSelectorState extends State<EmoticonSelector> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SelectorWrapper(
              emotionSelectorUp: widget.emotionSelectorUp,
              date: widget.date,
              emotion: widget.emotion,
              id: widget.id)),
    );
  }
}

class SelectorWrapper extends StatefulWidget {
  const SelectorWrapper(
      {Key? key,
      required this.emotionSelectorUp,
      required this.id,
      required this.date,
      required this.emotion})
      : super(key: key);
  final bool emotionSelectorUp;
  final String? id;
  final DateTime date;
  final String? emotion;

  @override
  State<SelectorWrapper> createState() => _SelectorWrapperState();
}

class _SelectorWrapperState extends State<SelectorWrapper> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 450),
      EmotionWrapper(
          emotionSelectorUp: widget.emotionSelectorUp,
          date: widget.date,
          emotion: widget.emotion,
          id: widget.id)
    ]);
  }
}

class EmotionWrapper extends StatefulWidget {
  const EmotionWrapper(
      {Key? key,
      required this.emotionSelectorUp,
      required this.date,
      required this.emotion,
      required this.id})
      : super(key: key);
  final bool emotionSelectorUp;
  final String? id;
  final DateTime date;
  final String? emotion;
  @override
  State<EmotionWrapper> createState() => _EmotionWrapperState();
}

class _EmotionWrapperState extends State<EmotionWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200, color: Colors.white, child: Row(children: []));
  }
}

List<Widget> EmoticonList(String emotion) {
  return [];
}
