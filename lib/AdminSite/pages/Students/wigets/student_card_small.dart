import 'package:flutter/material.dart';

import '../../../../Models/UserModle.dart';
import 'student_info_samll_card.dart';


class StudentCardsSmallScreen extends StatelessWidget {
  final List<UserModel> all_student;
  StudentCardsSmallScreen(this.all_student);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return  Container(
      height: 300,
      child: Column(
        children: [
          StudentInfoCardSmall(
            title: "Total Students",
            value: getTotalStudents(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          StudentInfoCardSmall(
            title: "Total Girls",
            value: getTotalGirls(),
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          StudentInfoCardSmall(
            title: "Total Boys",
            value: getTotalBoys(),
            onTap: () {},
          ),


        ],
      ),
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