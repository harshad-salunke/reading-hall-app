import 'package:flutter/material.dart';

import '../../../../Models/AttendanceModle.dart';
import '../../../../Models/UserModle.dart';
import 'info_samll_card.dart';


class OverviewCardsSmallScreen extends StatelessWidget {
  List<UserModel> total_user;
  List<AttendanceModle> today_attendance;
  OverviewCardsSmallScreen(this.today_attendance,this.total_user);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return  Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Total Students",
            value:total_user.length.toString(),
            onTap: () {},
            isActive: true,
            topColor: Colors.orange,

          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Today Present Students",
            value: today_attendance.length.toString(),
            onTap: () {},
            topColor: Colors.lightGreen,

          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Today Check In",
            value: today_attendance.length.toString(),
            onTap: () {},
            topColor: Colors.redAccent,

          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Today Check Out",
            value: getCheckOutDone(),
            onTap: () {},
            topColor:Colors.blue,

          ),

        ],
      ),
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