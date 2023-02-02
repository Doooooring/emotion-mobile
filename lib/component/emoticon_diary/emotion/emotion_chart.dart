import 'package:flutter/material.dart';

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
