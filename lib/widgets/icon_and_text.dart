import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
   IconAndText(
      {Key? key,
      required this.size,
      required this.text,
      required this.icon,
      required this.iconColor})
      : super(key: key);

  final String text;
  final IconData icon;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize15,
        ),
        const SizedBox(width: 4),
        SmallText(
          text: text,
          size: size,
        )
      ],
    );
  }
}
