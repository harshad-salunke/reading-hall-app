import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:kjcoemr_reading_hall/AdminSite/FirebaseDAO/AdminDatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/dailyAttendance/widgets/student_table.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';

import '../../Widgets/custom_text.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';


class DailyAttendancePage extends StatefulWidget {
  const DailyAttendancePage({Key? key}) : super(key: key);

  @override
  State<DailyAttendancePage> createState() => _DailyAttendancePageState();
}

class _DailyAttendancePageState extends State<DailyAttendancePage> {
  String display_date='';
  List<AttendanceModle> attendance_list=[];
  AdminDatabaseDAO adminDatabaseDAO=AdminDatabaseDAO();
  bool isLoaded=false;
  DateTime selectedDate=  DateTime.now();
  @override
  void initState() {
    DateTime dateTime=DateTime.now();
    display_date=DateFormat('dd-MMM-yyyy').format(dateTime);
    adminDatabaseDAO.readSelectedAttendance((List<AttendanceModle> list){
      attendance_list.clear();
      attendance_list.addAll(list);
      setState(() {
        isLoaded=true;
      });
    }, _getMonth(dateTime), getCurrentDate(dateTime));

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
                () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 70 : 30),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: "Date",
                      color: lightGrey,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(width: 5),
                    IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now()
                          );

                          if (pickedDate != null) {
                            selectedDate=pickedDate;
                            print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            display_date = DateFormat('dd-MMM-yyyy').format(pickedDate);
                            adminDatabaseDAO.readSelectedAttendance((List<AttendanceModle> list){
                              attendance_list.clear();
                              attendance_list.addAll(list);
                              setState(() {
                                isLoaded=true;
                              });
                            }, _getMonth(pickedDate), getCurrentDate(pickedDate));
                            setState(() {
                              isLoaded=false;
                            });
                          }
                        },
                        icon: Icon(Icons.date_range))
                  ],
                ),
                CustomText(
                  text: display_date,
                  color: lightGrey,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  text: "Total - "+attendance_list.length.toString(),
                  color: lightGrey,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
       Expanded(
              child: ListView(
                children: [
                  isLoaded?StudentsTable(attendance_list)
               :Center(child: CircularProgressIndicator()),
                ],
              )),
        ],
      ),
    );
  }
  String _getMonth(DateTime now) {
    String formattedDate = DateFormat('MMM y').format(now);

    return formattedDate;
  }



  String getCurrentDate(DateTime now) {
    String formattedDate = DateFormat('dd EEE').format(now);
    return formattedDate;
  }
}


