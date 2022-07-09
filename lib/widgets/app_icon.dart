import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  AppIcon({Key? key, required this.icon, required this.color, this.backgroundColor = const Color(0xFFccc7c5)})
      : super(key: key);

  final IconData icon;
  final Color color;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: backgroundColor),
      child: Icon(icon, color: color),
    );
  }
}
