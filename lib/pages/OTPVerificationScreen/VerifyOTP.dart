import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:kjcoemr_reading_hall/home.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../FirebaseDAO/FirebaseHandler.dart';
import '../../global/AppColors.dart';
import '../../global/MyButton.dart';
import 'ResendOTP.dart';



class VerifyOTP extends StatelessWidget {
  UserModel userModel;
  FirebaseHandler auth;
  bool isLogin;
   VerifyOTP(this.userModel,this.auth,this.isLogin);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: smallPadding, vertical: mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Verify OTP",
                  style: GoogleFonts.ubuntu(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    // context.read<AuthProvider>().toggleOTPView()
                    Navigator.pop(context);

                  },
                  child: Text(
                    "Edit Number",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),

            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 0.1 * getDeviceWidth(context),
              otpFieldStyle: OtpFieldStyle(
                borderColor: Colors.black,
                disabledBorderColor: Colors.black,
                errorBorderColor: Colors.black,
                enabledBorderColor: Colors.black,
                focusBorderColor: Colors.black,
              ),

              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                auth.otp=pin;
              },
              onChanged: (_){},
            ),
            verticalBox(mediumPadding),
            const ResendOTP(),
            Center(
              child: MyButton(
                onTap: () {
                 auth. startProgress(context);

                  auth.verifyOTP((bool error){
                    if(!error){
                      Navigator.popUntil(context, (route) => false);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>Home(userModel,null)));
                    }else{
                      auth.stopProgress(context);
                    }
                      }, userModel,isLogin
                  );

                },
                btn_text: "Verify",
              ),


            ),
          ],
        ),
      ),
    );
  }
}
