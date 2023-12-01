import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseDAO {
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  late final SharedPreferences prefs ;

  void CheckInData(UserModel userModel,Function() callback) {
    DateTime now = DateTime.now();
    String currentTimestamp = now.toString();
    AttendanceModle attendanceModle = new AttendanceModle(
        getCurrentTime(),
        "",
        userModel.name,
        getCurrentMonthForview(),
        getCurrentDate(),
        "0",
        getCurrentDate(),currentTimestamp,userModel.clg_branch?.split('.')[0],userModel.clg_year,userModel.roll_no);

    Map<String, dynamic> data = attendanceModle.toJson();
    String path =
        'Attendance/${userModel.phone_number}/${_getCurrentMonth()}/${getCurrentDate()}';
    print('attendance checkin' + data.toString());
    dbRef.child(path).set(data).then((value) {
      setGlobalAttendance(attendanceModle,userModel,callback);
    }).catchError((error) {
      print('Failed to push data to the database: $error');
    });
  }

  void CheckOutData(AttendanceModle attendanceModle,UserModel userModel,Function() callback) {
    attendanceModle.checkout=getCurrentTime();
    Map<String, dynamic> data = attendanceModle.toJson();
    String path ='Attendance/${userModel.phone_number}/${_getCurrentMonth()}/${getCurrentDate()}';
    print('attendance checkin' + data.toString());
    dbRef.child(path).set(data).then((value) {
      setGlobalAttendance(attendanceModle,userModel,callback);
    }).catchError((error) {
      print('Failed to push data to the database: $error');
    });
  }

  void setGlobalAttendance(AttendanceModle attendanceModle,UserModel userModel,Function() callback){
    Map<String, dynamic> data = attendanceModle.toJson();
    String path =
        'GlobalAttendance/${_getCurrentMonth()}/${getCurrentDate()}/${userModel.phone_number}';
    dbRef.child(path).set(data).then((value) {
      callback();
    }).catchError((error) {
      print('Failed to push data to the database: $error');
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



  void readAllAttendance(UserModel userModel, String month,
      Function(List<AttendanceModle> list) callback) {
    String path = 'Attendance/${userModel.phone_number}/${month}';
    List<AttendanceModle> attendancelist = [];
    dbRef.child(path).orderByChild('timestamp').onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        if (values != null) {
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

  Future<AttendanceModle> getDataFromStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString =
        sharedPreferences.getString('attendance_data').toString();
    Map<String, dynamic> map = json.decode(jsonString);
    print(map);
    AttendanceModle attendanceModel = AttendanceModle.fromJson(map);
    return attendanceModel;
  }

  void savetoStorage(UserModel userModel)async{
    prefs =  await SharedPreferences.getInstance();
    String personJson = json.encode(userModel.toJson());
    await prefs.setString('user_data',personJson );

  }

  void saveUserToFirebase(UserModel userModel,Function(bool isdone) callback){
    Map<String, dynamic> data = userModel.toJson();
    String path='Students/${userModel.phone_number}';
    dbRef.child(path).set(data).then((value) {
      savetoStorage(userModel);
      callback(true);
    }).catchError((error) {
      callback(false);
      print('Failed to push data to the database: $error');
    });
  }

  void checkUserPresentorNot(String number,Function(UserModel userModel,bool user_present) callback) {
    String path = 'Students/${number}';

    dbRef.child(path).onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        if (values != null) {
          UserModel userModel=UserModel(values['phone_number'],values['name'] ,values['roll_no'] ,values['uid'] ,values['join_date'] ,values['clg_name'] ,values['clg_year'] ,values['clg_branch'] ,values['gender'] );
          savetoStorage(userModel);
          callback(userModel,true);
        }else{
          UserModel userModel=UserModel('phone_number', 'name', 'roll_no', 'uid', 'join_date', 'clg_name', 'clg_year', 'clg_branch', 'gender');
          callback(userModel,false);
        }
      }
      else{
        UserModel userModel=UserModel('phone_number', 'name', 'roll_no', 'uid', 'join_date', 'clg_name', 'clg_year', 'clg_branch', 'gender');
        callback(userModel,false);
      }
    });

  }
}
