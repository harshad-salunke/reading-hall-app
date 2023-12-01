import 'package:flutter/material.dart';

import '../../../../Models/AttendanceModle.dart';
import '../../../../Models/UserModle.dart';
import 'info_card.dart';


class OverviewCardsLargeScreen extends StatelessWidget {
  List<UserModel> total_user;
  List<AttendanceModle> today_attendance;
  OverviewCardsLargeScreen(this.today_attendance,this.total_user);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return  Row(
      children: [
        InfoCard(
          title: "Total Students",
          value:total_user.length.toString(),
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Today Present Students",
          value: today_attendance.length.toString(),
          topColor: Colors.lightGreen,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Today Check In",
          value: today_attendance.length.toString(),
          topColor: Colors.redAccent,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Today Check Out",
          value: getCheckOutDone(),
          topColor:Colors.blue,

          onTap: () {},
        ),
      ],
    );
  }
  getCheckOutDone() {
    int count=0;
    for(AttendanceModle model in today_attendance){
      if(model.checkout!=''){
        count++;
      }
    }
    return count.toString();
  }
}