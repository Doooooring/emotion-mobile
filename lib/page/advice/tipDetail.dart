import "package:aeye/component/common/app_bar.dart";
import "package:flutter/material.dart";

class TipDetail extends StatelessWidget {
  const TipDetail({Key? key, required this.temperament, required this.title})
      : super(key: key);

  final String temperament;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Header(null), body: Container());
  }
}
