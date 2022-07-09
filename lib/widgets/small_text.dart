import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  SmallText(
      {Key? key,
      required this.text,
      this.size = 15,
      this.height = 1.5,
      this.color = const Color(0xFF89dad0)})
      : super(key: key);

  final String text;
  double size;
  Color? color;
  double height;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontFamily: 'Roboto', height: height),
    );
  }
}
