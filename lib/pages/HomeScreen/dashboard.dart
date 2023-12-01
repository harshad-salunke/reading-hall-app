import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kjcoemr_reading_hall/FirebaseDAO/DatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:kjcoemr_reading_hall/global/AppColors.dart';
import 'package:kjcoemr_reading_hall/global/CardView.dart';
import 'package:kjcoemr_reading_hall/global/CustomAppbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../Models/AttendanceModle.dart';
import '../../global/StudyCardView.dart';
import 'RecentActivitys.dart';
import 'startStudeyCard.dart';
class DashBoardScreen extends StatefulWidget {
  UserModel userModel;
  Function(AttendanceModle attendanceModle,bool isloading) callback;
  Function() seemorecallback;
  DashBoardScreen({required this.userModel,required this.callback,required this.seemorecallback});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DatabaseDAO databaseDAO=DatabaseDAO();
  Map<String, String>? myMap;
  AttendanceModle attendanceModle=AttendanceModle('-- --  -- -- --', '-- --  -- -- --', '', '', '', '-- --  -- -- --', '',null,"","","");
  AttendanceModle recentActivity=AttendanceModle('', '', '', '', '', '', '',null,"","","");

  List<AttendanceModle> attendance_list=[];
  bool isCallback=false;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(title: CustomAppBar(widget.userModel.name!.split(' ')[0].toString(),widget.userModel.gender.toString()),
        toolbarHeight: 76,
        elevation: 0,
        backgroundColor: app_bar_color,
      ),
    body: Container(
      margin: EdgeInsets.fromLTRB(5, 20, 5, 20),

      child: ListView(
        physics: BouncingScrollPhysics(), //use this for a bouncing experience

        children: [
          Row(
            children: [
              isCallback?CardView(attendanceModle.checkin.toString(),"Check In","assets/images/checkin.png","+100 pt"):getCardShimmer(),
              isCallback?CardView(attendanceModle.checkout.toString(),"Check Out","assets/images/checkout.png","+10 pt"):getCardShimmer(),
            ],
          ),
          Row(
            children: [
              isCallback?StartStudyCardView("","Start Study","assets/images/book_started.png","."):getCardShimmer(),
              isCallback?StudyCardView(attendanceModle.total_study.toString(),"Total Study","assets/images/book_finished.png","+100 pt"):getCardShimmer(),
            ],
          ),
          RecentActivitys(recentActivity,isCallback,(){
              widget.seemorecallback();
          })
        ],
      ),
    ),
    );
  }

  @override
  void initState() {
  DateTime  _selectedDate = DateTime.now();
    String selectedDate=DateFormat.yMMMM().format(_selectedDate);

  databaseDAO.readAllAttendance(widget.userModel as UserModel, selectedDate, (List<AttendanceModle> list){
    setState(() {
      isCallback=true;
      attendance_list.clear();
      attendance_list.addAll(list);
      if(attendance_list.length>0){
        print(attendance_list[0].month.toString());
        print(_getCurrentMonth());
        if(attendance_list[0].month?.trim()==_getCurrentMonth().trim()){
          attendanceModle=attendance_list[0];

          if(attendance_list.length>=2){
            recentActivity=attendance_list[1];
          }
        }else{
          recentActivity=attendance_list[0];
        }
      }

      widget.callback(attendanceModle,isCallback);

    });

  });


  }


  String _getCurrentMonth() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM y').format(now);
    return formattedDate;
  }

  Widget getCardShimmer(){
    return Expanded(
      child: Shimmer.fromColors(
          baseColor: Colors.grey[200] as Color,
          highlightColor: Colors.yellow[100] as Color,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Set the radius to half of the width/height to make it circular
              color: Colors.white,
            ),
            margin: EdgeInsets.all(5),
            height: 130)
      ),
    );
  }


}
