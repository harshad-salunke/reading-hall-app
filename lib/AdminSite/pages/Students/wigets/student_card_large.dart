import 'package:flutter/material.dart';

import '../../../../Models/UserModle.dart';
import 'student_info_card.dart';


class StudentCardsLargeScreen extends StatelessWidget {
  final List<UserModel> all_student;
  StudentCardsLargeScreen(this.all_student);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return  Row(
      children: [
        StudentInfoCard(
          title: "Total Students",
          value: getTotalStudents(),
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        StudentInfoCard(
          title: "Total Girls",
          value: getTotalGirls(),
          topColor: Colors.lightGreen,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        StudentInfoCard(
          title: "Total Boys",
          value: getTotalBoys(),
          topColor: Colors.redAccent,
          onTap: () {},
        ),

      ],
    );
  }
  getTotalStudents() {
    return all_student.length.toString();
  }

  getTotalGirls() {
    int count=0;
    for(UserModel m in all_student){
      if(m.gender=='Female'){
        count++;
      }
    }
    return count.toString();
  }
  getTotalBoys() {
    int count=0;
    for(UserModel m in all_student){
      if(m.gender=='Male'){
        count++;
      }
    }
    return count.toString();
  }
}