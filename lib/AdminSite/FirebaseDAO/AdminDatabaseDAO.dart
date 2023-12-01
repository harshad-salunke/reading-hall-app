import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDatabaseDAO {
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  late final SharedPreferences prefs ;



  void ReadAllStudents(Function(List<UserModel> all_student) callback){
    String path = 'Students';
    List<UserModel> all_students_list = [];
    dbRef.child(path).onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        if (values != null) {
          all_students_list.clear();
          values.forEach((key, value) {
            UserModel attendance = UserModel(value['phone_number'],value['name'] ,value['roll_no'] ,value['uid'] ,value['join_date'] ,value['clg_name'] , value['clg_year'], value['clg_branch'],value['gender'] );
            all_students_list.add(attendance);
          });
          callback(all_students_list);
        }
      }

    });
  }


  String _getCurrentMonth() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM y').format(now);

    return formattedDate;
  }

  String getCurrentMonthForview() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM y').format(now);

    return formattedDate;
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd EEE').format(now);
    return formattedDate;
  }


  void readTodayAttendance(Function(List<AttendanceModle> list) callback) {
    String path = 'GlobalAttendance/${_getCurrentMonth()}/${getCurrentDate()}';
    List<AttendanceModle> attendancelist = [];
    dbRef.child(path).orderByChild('timestamp').onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        if (values != null) {
          attendancelist.clear();
          values.forEach((key, value) {
            AttendanceModle attendance = AttendanceModle(
                value['checkin'],
                value['checkout'],
                value['name'],
                value['month'],
                value['date'],
                value['total_study'],
                value['id'],value['timestamp'],value['branch'],value['year'],value['roll_no']);
            print("date "+attendance.month.toString());
            attendancelist.add(attendance);
          });
        }
      }
      attendancelist.sort((a, b) => DateTime.parse(a.timestamp.toString()).compareTo(DateTime.parse(b.timestamp.toString())));
      attendancelist=attendancelist.reversed.toList();
      callback(attendancelist);
    });
  }

  void readLastAttendance(Function(List<AttendanceModle> list) callback,String month) {
    String path = 'GlobalAttendance/${_getCurrentMonth()}/${month}';
    List<AttendanceModle> attendancelist = [];
    dbRef.child(path).orderByChild('timestamp').onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        if (values != null) {
          attendancelist.clear();
          values.forEach((key, value) {
            AttendanceModle attendance = AttendanceModle(
                value['checkin'],
                value['checkout'],
                value['name'],
                value['month'],
                value['date'],
                value['total_study'],
                value['id'],value['timestamp'],value['branch'],value['year'],value['roll_no']);
            print("date "+attendance.month.toString());
            attendancelist.add(attendance);
          });
        }
      }
      attendancelist.sort((a, b) => DateTime.parse(a.timestamp.toString()).compareTo(DateTime.parse(b.timestamp.toString())));
      attendancelist=attendancelist.reversed.toList();
      callback(attendancelist);
    });
  }

  void readSelectedAttendance(Function(List<AttendanceModle> list) callback,String month,String date){
    String path = 'GlobalAttendance/${month}/${date}';
    List<AttendanceModle> attendancelist = [];
    dbRef.child(path).orderByChild('timestamp').onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        if (values != null) {
          attendancelist.clear();
          values.forEach((key, value) {
            AttendanceModle attendance = AttendanceModle(
                value['checkin'],
                value['checkout'],
                value['name'],
                value['month'],
                value['date'],
                value['total_study'],
                value['id'],value['timestamp'],value['branch'],value['year'],value['roll_no']);
            print("date "+attendance.month.toString());
            attendancelist.add(attendance);
          });
        }
      }
      attendancelist.sort((a, b) => DateTime.parse(a.timestamp.toString()).compareTo(DateTime.parse(b.timestamp.toString())));
      attendancelist=attendancelist.reversed.toList();
      callback(attendancelist);
    });
  }



}
