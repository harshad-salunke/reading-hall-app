import 'package:flutter/material.dart';

import '../../../Widgets/custom_text.dart';
import '../../../constants/style.dart';
import '../overview.dart';
import 'attendanc_info.dart';
import 'bar_chart.dart';

class AttendanceSectionSmall extends StatefulWidget {
  List<LastDaysReport> last_report;
  AttendanceSectionSmall(this.last_report);

  @override
  State<AttendanceSectionSmall> createState() => _AttendanceSectionSmallState();
}

class _AttendanceSectionSmallState extends State<AttendanceSectionSmall> {

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
        child: Column(
          children: [
            Container(
              height: 260,
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
                      child: SimpleBarChart.withSampleData(widget.last_report)),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 1,
              color: lightGrey,
            ),
            Container(
              height: 260,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Attendancenfo(
                        title: widget.last_report[0].name,
                        amount: widget.last_report[0].count.toString(),
                      ),
                      Attendancenfo(
                        title: widget.last_report[1].name,
                        amount: widget.last_report[1].count.toString(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Attendancenfo(
                        title: widget.last_report[2].name,
                        amount: widget.last_report[2].count.toString(),
                      ),
                      Attendancenfo(
                        title: widget.last_report[3].name,
                        amount: widget.last_report[3].count.toString(),
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


