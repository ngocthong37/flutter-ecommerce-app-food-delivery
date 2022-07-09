import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimentions.dart';

class BigText extends StatelessWidget {
  BigText({
    Key? key, 
    required this.text, 
    this.size = 20, 
    this.color= const Color(0xFF332d2b) ,
    this.overflow=TextOverflow.ellipsis}) : super(key: key);

  final String text;
  double size;
  Color? color;
  TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontSize: Dimensions.font20, 
        color: color, 
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto'
      ),
    );
  }
}
