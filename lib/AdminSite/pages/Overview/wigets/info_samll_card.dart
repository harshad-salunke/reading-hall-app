import 'package:flutter/material.dart';

import '../../../Widgets/custom_text.dart';
import '../../../constants/style.dart';


class InfoCardSmall extends StatelessWidget {
  final String title;
  final String value;
  final bool isActive;
  final Function() onTap;
  final Color topColor;


  const InfoCardSmall({Key? key,required this.title,required this.value, this.isActive = false,required this.onTap,required this.topColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: topColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isActive ? active : lightGrey, width: .5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: title, size: 24, color:  Colors.black ,weight: FontWeight.w300),
                CustomText(text: value, size: 24, weight: FontWeight.bold, color: isActive ? active : dark,)

              ],)
        ),
      ),
    );
  }
}