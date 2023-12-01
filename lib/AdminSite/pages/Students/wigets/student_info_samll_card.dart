import 'package:flutter/material.dart';

import '../../../Widgets/custom_text.dart';
import '../../../constants/style.dart';


class StudentInfoCardSmall extends StatelessWidget {
  final String title;
  final String value;
  final bool isActive;
  final Function() onTap;

  const StudentInfoCardSmall({Key? key,required this.title,required this.value, this.isActive = false,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isActive ? active : lightGrey, width: .5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: title, size: 15, weight: FontWeight.w300, color: isActive ? active : lightGrey,),
                CustomText(text: value, size: 15, weight: FontWeight.bold, color: isActive ? active : dark,)

              ],)
        ),
      ),
    );
  }
}