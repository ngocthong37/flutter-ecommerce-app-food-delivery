import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExandbleText extends StatefulWidget {
  const ExandbleText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<ExandbleText> createState() => _ExandbleTextState();
}

class _ExandbleTextState extends State<ExandbleText> {
  late String firstHalf;
  late String secondHaft;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5;

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHaft =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHaft = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHaft.isEmpty
      ? SmallText(text: firstHalf, color: AppColors.paraColor,)
      : Column(
          children: [
            hiddenText
              ? SmallText(text: firstHalf + '...', color: AppColors.paraColor,)
              : SmallText(text: firstHalf + secondHaft, color: AppColors.paraColor,),
            InkWell(
              onTap: () {
                setState(() {
                  hiddenText = !hiddenText;
                });
              },
              child: Row(
                children: [
                  SmallText(text: hiddenText ? 'Show more' : 'Show less'),
                  Icon(hiddenText ? Icons.arrow_drop_down : Icons.arrow_upward)
                ],
              ),
            )
          ],
        )
      );
    }
  }
