import "package:flutter/material.dart";

Map Month = {
  "1": "Jan",
  "2": "Feb",
  "3": "Mar",
  "4": "Apr",
  "5": "May",
  "6": "Jun",
  "7": "Jul",
  "8": "Aug",
  "9": "Sep",
  "10": "Oct",
  "11": "Nov",
  "12": "Dec"
};

class EmotionHead extends StatefulWidget {
  const EmotionHead(
      {Key? key, required this.date, required this.setInputEmotionUp})
      : super(key: key);
  final DateTime date;
  final void Function(bool) setInputEmotionUp;

  @override
  State<EmotionHead> createState() => _EmotionHeadState();
}

class _EmotionHeadState extends State<EmotionHead> {
  @override
  Widget build(BuildContext context) {
    String month = Month[widget.date.month.toString()];
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
                '${widget.date.year} ${month} ${widget.date.day}',
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
