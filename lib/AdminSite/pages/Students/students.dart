import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kjcoemr_reading_hall/AdminSite/FirebaseDAO/AdminDatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/Students/wigets/all_student_table.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/Students/wigets/student_card_large.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/Students/wigets/student_card_medium.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/Students/wigets/student_card_small.dart';

import '../../../Models/UserModle.dart';
import '../../Widgets/custom_text.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';


class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  AdminDatabaseDAO adminDatabaseDAO=AdminDatabaseDAO();
  bool isloaded=false;
  List<UserModel> all_student_list=[];
  @override
  void initState() {
    print('in init');
    adminDatabaseDAO.ReadAllStudents((List<UserModel> list){
      all_student_list.addAll(list);
      setState(() {
        isloaded=true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return isloaded? Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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

          Expanded(
              child: ListView(
                children: [
                  if (ResponsiveWidget.isLargeScreen(context) ||
                      ResponsiveWidget.isMediumScreen(context))
                    if (ResponsiveWidget.isCustomSize(context))
                      StudentCardsMediumScreen(all_student_list)
                    else
                      StudentCardsLargeScreen(all_student_list)
                  else
                    StudentCardsSmallScreen(all_student_list),

                  AllStudentTable(all_student_list)],
              )),
        ],
      ),
    ):Center(child: CircularProgressIndicator());
  }
}



