

import 'package:data_table_2/data_table_2.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';

import '../../../Widgets/custom_text.dart';
import '../../../constants/style.dart';
import 'package:flutter/material.dart';

import '../../../helpers/responsiveness.dart';

/// Example without datasource
class PresentStudentsTable extends StatelessWidget {
  List<AttendanceModle> today_attendance;
  PresentStudentsTable(this.today_attendance);
  @override
  Widget build(BuildContext context) {
    return
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
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "Today Present Students",
                  color: Colors.green,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            Column(
              children:[ SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing:ResponsiveWidget.isSmallScreen(context)?40:ResponsiveWidget.isMediumScreen(context)?100:180,
                  horizontalMargin: 12,
                  columns: [
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text('Branch'),
                    ),
                    DataColumn(
                      label: Text('Year'),
                    ),
                    DataColumn(
                      label: Text('Roll No'),
                    ),
                    DataColumn(
                      label: Text('Check In'),
                    ),
                    DataColumn(
                      label: Text('Check Out'),
                    ),
                    DataColumn(
                      label: Text('Profile'),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    today_attendance.length,
                        (index) => DataRow(
                        cells: [
                          DataCell(CustomText(text: today_attendance[index].name)),
                          DataCell(CustomText(text: today_attendance[index].branch)),
                          DataCell(CustomText(text: today_attendance[index].year)),
                          DataCell(CustomText(text: today_attendance[index].roll_no)),
                          DataCell(CustomText(text: today_attendance[index].checkin)),
                          DataCell(CustomText(text: today_attendance[index].checkout)),
                          DataCell(
                            Container(
                              decoration: BoxDecoration(
                                color: light,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: active, width: .5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: CustomText(
                                text: "Profile",
                                color: active.withOpacity(.7),
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                  ),

                ),
              ),]
            )
          ],
        ),
      );
  }
}