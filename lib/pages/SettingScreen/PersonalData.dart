import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/FirebaseDAO/DatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/FirebaseDAO/FirebaseHandler.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:kjcoemr_reading_hall/pages/OTPVerificationScreen/VerifyOTP.dart';
import 'package:kjcoemr_reading_hall/pages/RegisterScreen/CollegeNameField.dart';
import 'package:kjcoemr_reading_hall/pages/RegisterScreen/NumberField.dart';
import 'package:kjcoemr_reading_hall/pages/RegisterScreen/RegistrationControler.dart';

import '../../global/AppColors.dart';
import '../../global/MyButton.dart';
import '../../global/MyTextField.dart';
import '../NotificationScreen/DefaultAppBar.dart';
import '../NotificationScreen/DefaultBackButton.dart';
class PersonalScreen extends StatefulWidget {
  UserModel userModel;
  PersonalScreen(this.userModel);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  RegistrationController registrationController=new RegistrationController();
DatabaseDAO databaseDAO=DatabaseDAO();
  @override
  void initState() {
     registrationController.phone_numberController.text=widget.userModel.phone_number.toString();
     registrationController.gender_Controller.text=widget.userModel.gender.toString();
     registrationController.college_branchController.text=widget.userModel.clg_branch.toString();
     registrationController.college_yearController.text=widget.userModel.clg_year.toString();
     registrationController.full_nameController.text=widget.userModel.name.toString();
     registrationController.roll_noController.text=widget.userModel.roll_no.toString();
registrationController.college_nameController.text=widget.userModel.clg_name.toString();
  }

  var clg_list=[
    ' KJCOEMR.(K J COLLEGE OF ENGINEERING AND MANAGEMENT RESEARCH)',
    'TCOER.(Trinity College of Engineering and Research)',
    'TAE.(Trinity Academy Of Engineering)',
    'TIMR.(Trinity Institute Of Management And Research)',
    ' TCOP.(Trinity College Of Pharmacy)',
    'TCOA.(Trinity College of Architecture)',
    'TPP.(Trinity   Polytechnic, Pune)',
    'TIS.(Trinity International School)'
  ];
  var clg_year=[
    'FE',
    'SE',
    'TE',
    'BE'
  ];
  var gender_list=[
    "Male",
    "Female",
    "Other"
  ];
  var clg_branch=[
    'Computer',
    'IT',
    'Mechanical',
    'Civil',
    'ENTC',
    'Electical'
    // MBA
    // B.Pharma
    // D.Pharma
    // B.Pharma(Lateral)
    // Pharmacy
    // Pharmaceutics
    // B.Arch(Architecture)
    // Engineering Science
    // Construction Technology
    // Design Engineering
    // Primary
    // Seconday
    // Senior Secondary
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_bar_color,
      appBar:  DefaultAppBar(
        title: 'Personal Data',
        child: DefaultBackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 25),

              // username textfield
              NumberField(
                controller: registrationController.phone_numberController,
                hintText: 'Phone No',
                obscureText: false,
                focusNode: FocusNode(),
                isenalble: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: registrationController.full_nameController,
                hintText: 'Full Name',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              MyTextField(
                controller: registrationController.roll_noController,
                hintText: 'Roll No',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              CollegeNameField(
                controller: registrationController.college_nameController,
                hintText: 'College Name',
                obscureText: false,
                items: clg_list,
              ),
              const SizedBox(height: 10),
              CollegeNameField(
                controller: registrationController.college_yearController,
                hintText: 'College year',
                obscureText: false,
                items: clg_year,
              ),
              const SizedBox(height: 10),
              CollegeNameField(
                controller: registrationController.college_branchController,
                hintText: 'College Branch',
                obscureText: false,
                items: clg_branch,
              ),
              const SizedBox(height: 10),
              CollegeNameField(
                controller: registrationController.gender_Controller,
                hintText: 'Gender',
                items: gender_list,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              // forgot password?

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: (){
                  if(!registrationController.validation()){
                    return;
                  }

                  databaseDAO.saveUserToFirebase(registrationController.getUserData(), (bool isdone){
                    if(isdone){
                      DatasaveToast();
                    }else{
                      dataSaveError();
                    }
                  });

                },
                btn_text: "Save",
              ),

              const SizedBox(height: 50),

            ],
          ),
        ),
      ),

    );
  }

  void DatasaveToast(){
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Hii, there!',
        message: 'Your Data Saved Successfully',
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

  }

  void dataSaveError(){

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Oh, Snap!',
        message: 'Check your internet Connectivity ',
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

  }
}
