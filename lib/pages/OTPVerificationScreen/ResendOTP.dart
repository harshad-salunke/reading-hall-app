import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ResendOTP extends StatefulWidget {
  const ResendOTP({super.key});

  @override
  State<ResendOTP> createState() => _ResendOTPState();
}

class _ResendOTPState extends State<ResendOTP> {
  int secondsRemaining = 30;
  late String timerText;
  bool enableResend = false;
  late Timer timer;

  @override
  initState() {
    super.initState();
    _startTimer();
  }

  @override
  dispose(){

    super.dispose();
  }

  _startTimer() {
    timerText = "00:$secondsRemaining";
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
          secondsRemaining >= 10
              ? timerText = "00:$secondsRemaining"
              : timerText = "00:0$secondsRemaining";
        });
      } else {
        setState(() {
          enableResend = true;
          timerText = "";
          timer.cancel();
          secondsRemaining = 30;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            if (enableResend) {
              // context.read<AuthProvider>().sendOTP();
              setState(() {
                enableResend = false;
                _startTimer();
              });


            }
          },
          child: Text(
            "Resend OTP",
            style: GoogleFonts.openSans(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          enableResend ? "" : "in  $timerText",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
