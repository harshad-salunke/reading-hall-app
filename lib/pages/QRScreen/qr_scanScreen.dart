import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kjcoemr_reading_hall/FirebaseDAO/DatabaseDAO.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'ImageScannerOverlay.dart';
class QR_ScanScreen extends StatefulWidget {
  AttendanceModle attendanceModle;
  UserModel userModle;
  QR_ScanScreen(this.attendanceModle,this.userModle);

  @override
  State<QR_ScanScreen> createState() => _QR_ScanScreenState();
}

class _QR_ScanScreenState extends State<QR_ScanScreen> {
  AudioPlayer player = AudioPlayer();

  final key=GlobalKey(debugLabel: 'QR');
bool isDetected=false;
DatabaseDAO databaseDAO=DatabaseDAO();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child:Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              MobileScanner(
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');

                    String link='https://kjei.page.link/reading_hall';
                    if(barcode.rawValue==link && !isDetected){
                      barcodes.clear();
                      isDetected=true;
                      if(widget.attendanceModle.checkin=='-- --  -- -- --'){
                        databaseDAO.CheckInData(widget.userModle,dataSavedCallbackCheckIn);
                      }else if(widget.attendanceModle.checkout==''){
                        databaseDAO.CheckOutData(widget.attendanceModle, widget.userModle,dataSavedCallbackCheckOut);
                        print("check out");
                      }else{
                        print("entry done");
                      }
                    }

                  }
                  barcodes.clear();
                },
              ),
              // buildQrView(context),
              ImageScannerOverlay(overlayColour:Colors.black.withOpacity(0.5)),
              // Positioned(bottom:10,child: buildResult()),
              Positioned(child:Container (
                width:screenWidth,
               margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
               child : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_sharp),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),

                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB((screenWidth/4)-20, 0, 0, 0),
                        child: Text(
                         'Scan a code',
                     textAlign: TextAlign.center,
                     style:   GoogleFonts.acme(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ),

                    ]
                  ),
              ), top: 5,)
            ],
          ),
        )
    );
  }

  void dataSavedCallbackCheckIn(){
    playSound();
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Well Done!',
        message: 'Wellcome ${widget.userModle.name} . You Check In Successfully',
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    Navigator.pop(context);

  }

  void dataSavedCallbackCheckOut(){
    playSound();
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Well Done!',
        message: 'See You Again ${widget.userModle.name} . You Check Out Successfully',
        contentType: ContentType.help,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    Navigator.pop(context);

  }

  Future<void> playSound() async {
    String audioasset = "assets/audio/tone2.mp3";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List  soundbytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if(result == 1){ //play success
      print("Sound playing successful.");
    }else{
      print("Error while playing sound.");
    }
  }
  buildResult() {

    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.white24
      ),
      child: Text(
        'Scan a code',
        maxLines: 3,
      ),
    );
  }

}
