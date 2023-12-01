import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/FirebaseDAO/FirebaseHandler.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:kjcoemr_reading_hall/pages/OTPVerificationScreen/VerifyOTP.dart';
import 'package:kjcoemr_reading_hall/pages/RegisterScreen/CollegeNameField.dart';
import 'package:kjcoemr_reading_hall/pages/RegisterScreen/NumberField.dart';
import 'package:kjcoemr_reading_hall/pages/RegisterScreen/RegistrationControler.dart';

import '../../global/AppColors.dart';
import '../../global/MyButton.dart';
import '../../global/MyTextField.dart';
import '../../global/SquareTile.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegistrationController registrationController=new RegistrationController();
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
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
                   margin: EdgeInsets.fromLTRB(8, 10, 0, 0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
               Container(
                 margin: EdgeInsets.fromLTRB(25, 3, 0, 0),

                 child: Text("Hello!  Register to get \nStarted",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
               ),


                // welcome back, you've been missed!
                const SizedBox(height: 25),

                // username textfield
                NumberField(
                  controller: registrationController.phone_numberController,
                  hintText: 'Phone No',
                  obscureText: false,
                  focusNode: FocusNode(),
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
                    FirebaseHandler auth=new FirebaseHandler();
                    auth.phoneNo=registrationController.phone_numberController.text;
                    auth.sendOTP(context);
                    Navigator. push(context, MaterialPageRoute(builder: (BuildContext context){ return VerifyOTP(registrationController.getUserData(),auth,false); }));

                  },
                  btn_text: "Sign In",
                ),

                const SizedBox(height: 50),

              ],
            ),
          ),
        ),

    );
  }
}
