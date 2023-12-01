import 'package:flutter/material.dart';

import '../../../Widgets/custom_text.dart';
import '../../../constants/style.dart';
import '../overview.dart';
import 'attendanc_info.dart';
import 'bar_chart.dart';


class AttendanceSectionLarge extends StatelessWidget {
List<LastDaysReport> last_report;
AttendanceSectionLarge(this.last_report);
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Last Reports",
                  size: 20,
                  weight: FontWeight.bold,
                  color: Colors.green,
                ),
                Container(
                    width: 600,
                    height: 200,
                    child: SimpleBarChart.withSampleData(last_report)),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Attendancenfo(
                      title: last_report[0].name,
                      amount: last_report[0].count.toString(),
                    ),
                    Attendancenfo(
                      title: last_report[1].name,
                      amount: last_report[1].count.toString(),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Attendancenfo(
                      title: last_report[2].name,
                      amount: last_report[2].count.toString(),
                    ),
                    Attendancenfo(
                      title: last_report[3].name,
                      amount: last_report[3].count.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}