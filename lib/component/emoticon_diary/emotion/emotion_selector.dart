import 'package:flutter/material.dart';

class EmoticonSelector extends StatefulWidget {
  const EmoticonSelector({Key? key, required this.emotionSelectorUp})
      : super(key: key);
  final bool emotionSelectorUp;

  @override
  State<EmoticonSelector> createState() => _EmoticonSelectorState();
}

class _EmoticonSelectorState extends State<EmoticonSelector> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
