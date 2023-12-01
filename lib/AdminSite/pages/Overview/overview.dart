import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:kjcoemr_reading_hall/AdminSite/FirebaseDAO/AdminDatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/Overview/wigets/attendance_section_large.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/Overview/wigets/attendance_section_samll.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/Overview/wigets/present_student_table.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';

import '../../../Models/UserModle.dart';
import '../../Widgets/custom_text.dart';
import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import 'wigets/overview_card_large.dart';
import 'wigets/overview_card_medium.dart';
import 'wigets/overview_card_small.dart';


class OverViewPage extends StatefulWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
AdminDatabaseDAO adminDatabaseDAO=AdminDatabaseDAO();
List<AttendanceModle> today_attendance=[];
List<UserModel> totalUsers=[];
List<LastDaysReport> last_days_reports=[];
bool isLoaded=false;

@override
  void initState() {
    adminDatabaseDAO.ReadAllStudents((List<UserModel>all_student) {
      totalUsers.clear();
      totalUsers.addAll(all_student);

      setState(() {
      });
    });
    adminDatabaseDAO.readTodayAttendance((List<AttendanceModle > list_attendance){
      setState(() {

        today_attendance.clear();
        today_attendance.addAll(list_attendance);
        isLoaded=true;
      });
    });

    getLastDates();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
                () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 30),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        isLoaded? Expanded(
              child: ListView(
                children: [
                  if (ResponsiveWidget.isLargeScreen(context) ||
                      ResponsiveWidget.isMediumScreen(context))
                    if (ResponsiveWidget.isCustomSize(context))
                      OverviewCardsMediumScreen(today_attendance,totalUsers)
                    else
                      OverviewCardsLargeScreen(today_attendance,totalUsers)
                  else
                    OverviewCardsSmallScreen(today_attendance,totalUsers),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    AttendanceSectionLarge(last_days_reports)
                  else
                    AttendanceSectionSmall(last_days_reports),

                  PresentStudentsTable(today_attendance),

                ],
              )
        ):Expanded(child: Center(child: CircularProgressIndicator(),))
        ],
      ),
    );
  }

  void getLastDates() {
    DateTime today = DateTime.now();
    DateTime previousDay1 = today.subtract(Duration(days: 1));
    DateTime previousDay2 = today.subtract(Duration(days: 2));
    DateTime previousDay3 = today.subtract(Duration(days: 3));

    DateFormat dateFormat = DateFormat('dd EEE');
    DateFormat dateFormatMonth=DateFormat('dd MMM');

    last_days_reports.add(LastDaysReport("Today", 0));
    last_days_reports.add(LastDaysReport("Yesterday", 0));
    last_days_reports.add(LastDaysReport(dateFormatMonth.format(previousDay2), 0));
    last_days_reports.add(LastDaysReport(dateFormatMonth.format(previousDay3),0));

    adminDatabaseDAO.readLastAttendance(
            (List<AttendanceModle> list){
              last_days_reports[0].count=list.length;
              setState(() {
              });
            }, dateFormat.format(today));

    //yesterday
    adminDatabaseDAO.readLastAttendance(
            (List<AttendanceModle> list){
              last_days_reports[1].count=list.length;

              setState(() {
          });

        }, dateFormat.format(previousDay1));
    //2 days
    adminDatabaseDAO.readLastAttendance(
            (List<AttendanceModle> list){
              last_days_reports[2].count=list.length;

          setState(() {
          });
        }, dateFormat.format(previousDay2));
    //3 days
    adminDatabaseDAO.readLastAttendance(
            (List<AttendanceModle> list){
              last_days_reports[3].count=list.length;

              setState(() {
          });
        }, dateFormat.format(previousDay3));


  }
}

class LastDaysReport{
  String? name;
  int? count;
  LastDaysReport(this.name,this.count);
}