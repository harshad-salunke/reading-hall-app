import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../global/AppColors.dart';
import 'TimerHelper.dart';
import 'TimerSingleton.dart';

class StartStudyCardView extends StatefulWidget {
  String time;
  String text;
  String icon;
  String points;

  StartStudyCardView(this.time, this.text, this.icon, this.points);

  @override
  State<StartStudyCardView> createState() => _StartStudyCardView();
}

class _StartStudyCardView extends State<StartStudyCardView> {
  TimerSingleton timer = TimerSingleton();

  bool isStudyStarted = false;

  String  timerText (int? _secondsElapsed){
    if(_secondsElapsed==null){
      _secondsElapsed=0;
    }
    int hours = _secondsElapsed !~/ 3600;
    int minutes = (_secondsElapsed ~/ 60) % 60;
    int seconds = _secondsElapsed % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     _secondsElapsed++;
    //   });
    // });
    timer.startTimer((){
      setState(() {
        isStudyStarted=true;
      });
    });
  }

  void _stopTimer() {
    // _timer?.cancel();
    // setState(() {
    //   _secondsElapsed = 0;
    // });
   timer.stopTimer();
   setState(() {
     isStudyStarted=false;
   });

  }

  @override
  Widget build(BuildContext context) {

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isStudyStarted) {
                    setState(() {
                      isStudyStarted=false;
                      _stopTimer();
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 130,
                  color: isStudyStarted ? light_green : Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              widget.icon,
                              height: 28,
                              width: 28,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.text,
                              style: GoogleFonts.teko(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      isStudyStarted
                          ? Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          '${timerText(timer.counter)}',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.bebasNeue(
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
                      )
                          : Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isStudyStarted = true;
                              _startTimer();
                            });
                            // Respond to button press
                          },
                          child: Text('Start'),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      isStudyStarted
                          ? Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Click to Stop",
                                style: GoogleFonts.quicksand(
                                    color: CupertinoColors.inactiveGray,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              Text(
                                widget.points,
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 0,
                              )
                            ],
                          ))
                          : Container()
                    ],
                  ),
                ),
              ),
            );
  }


}
