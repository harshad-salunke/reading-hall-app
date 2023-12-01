import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kjcoemr_reading_hall/AdminSite/helpers/responsiveness.dart';

import '../../../../Models/UserModle.dart';
import '../../../Widgets/custom_text.dart';
import '../../../constants/style.dart';




/// Example without datasource
class AllStudentTable extends StatelessWidget {
 final List<UserModel> all_student_list;
AllStudentTable(this.all_student_list);
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child:   Column(
            children:[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing:ResponsiveWidget.isSmallScreen(context)?40:ResponsiveWidget.isMediumScreen(context)?100:180,
                  horizontalMargin: 12,
                  columns: [
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text('College'),
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
                      label: Text('Gender'),
                    ),

                    DataColumn(
                      label: Text('Phone No'),
                    ),
                    DataColumn(
                      label: Text('Registered date'),
                    ),

                  ],
                  rows: List<DataRow>.generate(
                    all_student_list.length,
                        (index) => DataRow(
                        cells: [
                          DataCell(CustomText(text: all_student_list[index].name)),
                          DataCell(CustomText(text: all_student_list[index].clg_name?.split('.')[0])),

                          DataCell(CustomText(text: all_student_list[index].clg_branch)),
                          DataCell(CustomText(text: all_student_list[index].clg_year)),
                          DataCell(CustomText(text: all_student_list[index].roll_no)),
                          DataCell(CustomText(text: all_student_list[index].gender)),
                          DataCell(
                            Container(
                              decoration: BoxDecoration(
                                color: light,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: active, width: .5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: CustomText(
                                text: "Call",
                                color: active.withOpacity(.7),
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(CustomText(text: all_student_list[index].join_date)),


                        ]),
                  ),

                ),
              ),]
        )
    );
  }
}