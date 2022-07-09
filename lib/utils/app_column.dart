import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColum extends StatelessWidget {
  const AppColum(
      {Key? key,
      required this.text,
      required this.numOfStar,
      required this.numOfComment,
      required this.stateIcon,
      required this.locationIcon,
      required this.timeIcon, required this.state, required this.numOfKm, required this.time})
      : super(key: key);

  final String text;
  final double numOfStar;
  final int numOfComment;
  final IconData stateIcon;
  final IconData locationIcon;
  final IconData timeIcon;
  final String state;
  final double numOfKm;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(text: text),
      SizedBox(height: Dimensions.height15),
      Row(
        children: [
          ...List.generate(
              5,
              (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: 15,
                  )),
          SizedBox(width: Dimensions.width8),
          SmallText(text: '$numOfStar', color: Colors.grey),
          SizedBox(width: Dimensions.width8),
          SmallText(
            text: "$numOfComment",
            color: Colors.grey,
          ),
          SmallText(
            text: " comments",
            color: Colors.grey,
          ),
        ],
      ),
      SizedBox(height: Dimensions.height15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndText(
              size: 15,
              text: state,
              icon: Icons.circle_sharp,
              iconColor: Colors.grey),
          IconAndText(
              size: 15,
              text: '$numOfKm km',
              icon: Icons.location_on,
              iconColor: AppColors.mainColor),
          IconAndText(
              size: 15,
              text: '$time min',
              icon: Icons.access_time_rounded,
              iconColor: Colors.red),
        ],
      )
    ]);
  }
}
