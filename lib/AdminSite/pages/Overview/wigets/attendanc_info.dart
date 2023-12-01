import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class Attendancenfo extends StatelessWidget {
  final String? title;
  final String ?amount;

  const Attendancenfo({Key? key, this.title, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
            TextSpan(
                text: "$title \n\n",
                style: TextStyle(color: lightGrey, fontSize: 16,fontWeight: FontWeight.bold)),
            TextSpan(
                text: " $amount",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
    );
  }
}