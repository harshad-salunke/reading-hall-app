import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kjcoemr_reading_hall/FirebaseDAO/DatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';
import 'package:kjcoemr_reading_hall/pages/RecordScreen/RecordCardView.dart';
import 'package:shimmer/shimmer.dart';

import '../../Models/UserModle.dart';
import '../../global/AppColors.dart';
import '../../global/CustomAppbar.dart';
import 'package:intl/intl.dart';

class RecordScreen extends StatefulWidget {
  UserModel userModel;
  RecordScreen({required this.userModel});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late DateTime _selectedDate;
DatabaseDAO databaseDAO=DatabaseDAO();
  List<AttendanceModle> attendance_list=[];

  List<Widget> shimmerEffect=[
    Container(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[200] as Color,
            highlightColor: Colors.yellow[100] as Color,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Set the radius to half of the width/height to make it circular
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(5),
                height: 80)
        ),
      ),
    ),

  ];
  bool isCallback=false;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    String date=DateFormat.yMMMM().format(_selectedDate);
    readDataFromDatabase(date);

  }

  void _onPreviousMonth() {
    setState(() {
      isCallback=false;
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
      attendance_list.clear();

      String date=DateFormat.yMMMM().format(_selectedDate);
      readDataFromDatabase(date);
    });
  }

  void _onNextMonth() {
    setState(() {
      isCallback=false;
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
      attendance_list.clear();
      String date=DateFormat.yMMMM().format(_selectedDate);
      readDataFromDatabase(date);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: CustomAppBar(widget.userModel.name!.split(' ')[0].toString(),widget.userModel.gender.toString()),
        toolbarHeight: 76,
        elevation: 0,
        backgroundColor: app_bar_color,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 10),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Set the radius to half of the width/height to make it circular
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: _onPreviousMonth,
                ),
                Text(
                  DateFormat.yMMMM().format(_selectedDate),
                  style:  GoogleFonts.acme(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: _onNextMonth,
                ),
              ],
            ),
          ),

          attendance_list.length==0?Container(child: _noDataAvailable()):
          Expanded(
            child: ListView.builder(
              itemCount: attendance_list.length,
              itemBuilder: (BuildContext context, int index) {
                return RecordCardView(attendance_list[index]);
                  // other widget properties as needed
              },
            ),
          ),



        ],
      ),
    );
  }
  _noDataAvailable() {
    return Expanded(
      child: Container(
        child:isCallback? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'No  Data \n at the  moment',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ): SingleChildScrollView(
          child: Column(
            children: [
              shimmerEffect[0],
              shimmerEffect[0],
              shimmerEffect[0],
              shimmerEffect[0],
              shimmerEffect[0],
              shimmerEffect[0],
            ],
          ),
        )

      ),
    );
  }

  void readDataFromDatabase(String selectedDate) {
    databaseDAO.readAllAttendance(widget.userModel as UserModel, selectedDate, (List<AttendanceModle> list){
     print(list);
      setState(() {
        isCallback=true;
        attendance_list.clear();
        attendance_list.addAll(list);
      });

    });
  }
}
