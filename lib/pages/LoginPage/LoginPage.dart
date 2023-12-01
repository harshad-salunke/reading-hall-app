import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/FirebaseDAO/DatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:kjcoemr_reading_hall/global/AppColors.dart';
import 'package:kjcoemr_reading_hall/pages/RegisterScreen/register_page.dart';

import '../../FirebaseDAO/FirebaseHandler.dart';
import '../../global/MyButton.dart';
import '../../global/MyTextField.dart';
import '../../global/SquareTile.dart';
import '../OTPVerificationScreen/VerifyOTP.dart';
import '../RegisterScreen/NumberField.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LoginPage extends StatelessWidget {

  // text editing controllers
  final phone_numberController = TextEditingController();
  DatabaseDAO databaseDAO=DatabaseDAO();
  FocusNode focusNode=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_bar_color,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  child: Image.asset(
                    'assets/images/trinitylogo.png',
                    height: 150,
                  ),
                ),


                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                NumberField(
                  controller: phone_numberController,
                  hintText: 'Phone No',
                  obscureText: false,
                  focusNode: focusNode,
                ),
                const SizedBox(height: 10),

                // sign in button
                MyButton(
                  onTap: (){
                    focusNode.unfocus();
                    if(phone_numberController.text==''|| phone_numberController.text.length<10){
                      return;
                    }
                    FirebaseHandler auth=new FirebaseHandler();
                    auth.startProgress(context);
                    databaseDAO.checkUserPresentorNot(phone_numberController.text,(UserModel usermodle,bool ispresent){
                      if(ispresent){
                        auth.stopProgress(context);
                        auth.phoneNo=phone_numberController.text;
                        auth.sendOTP(context);
                        Navigator. push(context, MaterialPageRoute(builder: (BuildContext context){ return VerifyOTP(usermodle,auth,true); }));
                      }else{
                        auth.stopProgress(context);
                        final snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Oh, Snap!',
                            message:
                            'No account found . Please Register your account first!',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    });

                  },
                  btn_text: "Login In",
                ),

                const SizedBox(height: 40),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'assets/images/apple.png')
                  ],
                ),

                const SizedBox(height: 20),

                Text(
                  'Made With ❤️ By\nHarshad Salunke',
                  style: TextStyle(color: Colors.black),
                ),

                const SizedBox(height: 20),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                     GestureDetector(
                       onTap: (){
                         Navigator. push(context, MaterialPageRoute(builder: (BuildContext context){ return RegisterScreen(); }));
                       },
                       child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                     ),
                  ],
                ),
                const SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }
}