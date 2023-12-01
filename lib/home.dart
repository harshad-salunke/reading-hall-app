
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';

import 'package:kjcoemr_reading_hall/pages/HomeScreen/dashboard.dart';
import 'package:kjcoemr_reading_hall/pages/NotificationScreen/notification.dart';
import 'package:kjcoemr_reading_hall/pages/QRScreen/qr_scanScreen.dart';
import 'package:kjcoemr_reading_hall/pages/RecordScreen/record.dart';
import 'package:kjcoemr_reading_hall/pages/SettingScreen/setting.dart';

import 'FirebaseDAO/DatabaseDAO.dart';

class Home extends StatefulWidget {
  UserModel userModel;
   PendingDynamicLinkData? initialLink;
Home(this.userModel,this.initialLink);
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  AudioPlayer player = AudioPlayer();

  DatabaseDAO databaseDAO=new DatabaseDAO();
  AttendanceModle attendanceModle=AttendanceModle('-- --  -- -- --', '', 'name', 'month', 'date', 'total_study', 'id', 'timestamp',"","","");
  bool isLoaded=false;
  bool isDynamiclink=false;
late final List<Widget> Screens ;

void callbackFromDashBoard(AttendanceModle Modle,bool isloading){
   attendanceModle=Modle;
   isLoaded=isloading;
   if(isDynamiclink){
     DynamicLinkData();
   }
}
void seeMoreCallback(){
  setState(() {
    currentTab = 1;
  });
}
@override
  void initState() {


  if (widget.initialLink != null) {
      isDynamiclink=true;
  }
 Screens= [
    DashBoardScreen(userModel:widget. userModel,callback: callbackFromDashBoard,seemorecallback: seeMoreCallback,),
    RecordScreen(userModel: widget.userModel,),
    NotificationScreen(userModel:widget. userModel,),
    SettingScreen(userModel: widget.userModel,)
  ];
  }

  int currentTab = 0;
  PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: PageStorage(
        child: Screens[currentTab],
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 0;
          });
          if(isLoaded){
            setAttedance();
          }else{
         pleaseWaitDataLoad();
          }
        },
        child: Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(

        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

          Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 20,

                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.black : Colors.grey,
                        ),
                        SizedBox(height: 2,),

                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 12,
                              color:
                                  currentTab == 0 ? Colors.black : Colors.grey),
                        )
                      ],
                    ),

                  ),
                  MaterialButton(
                    minWidth: 20,

                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          color: currentTab == 1 ? Colors.black : Colors.grey,
                        ),
                        SizedBox(height: 2,),
                        Text(
                          'Productive',
                          style: TextStyle(
                            fontSize: 12,
                              color:
                                  currentTab == 1 ? Colors.black : Colors.grey),

                        )
                      ],
                    ),

                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 20,

                    onPressed: () {
                      setState(() {
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: currentTab == 2 ? Colors.black : Colors.grey,
                        ),
                        SizedBox(height: 2,),

                        Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 12,
                              color:
                                  currentTab == 2 ? Colors.black : Colors.grey),
                        )
                      ],
                    ),

                  ),
                  MaterialButton(
                    minWidth: 20,

                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab == 3 ? Colors.black : Colors.grey,
                        ),
                        SizedBox(height: 2,),

                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 12,
                              color:
                                  currentTab == 3 ? Colors.black : Colors.grey),
                        )
                      ],
                    ),

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void DynamicLinkData() {

    if((isDynamiclink && isLoaded) && attendanceModle.checkin!='-- --  -- -- --'  && attendanceModle.checkout!='-- --  -- -- --' && attendanceModle.checkout!=''){
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Hii , there!',
          message: 'Your Entry Already Present!',
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);    }
    else if(isDynamiclink && isLoaded){
      isDynamiclink=false;

      if(attendanceModle.checkin=='-- --  -- -- --'){
        databaseDAO.CheckInData(widget.userModel,dataSavedCallbackCheckIn);
      }else if(attendanceModle.checkout==''){
        databaseDAO.CheckOutData(attendanceModle, widget.userModel,dataSavedCallbackCheckOut);
        print("check out");
      }else{
        print("entry done");
      }
    }



  }
  void dataSavedCallbackCheckIn(){
    playSound();
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Well Done!',
        message: 'Wellcome ${widget.userModel.name} . You Check In Successfully',
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

  }


  Future<void> dataSavedCallbackCheckOut() async {
    playSound();
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Well Done!',
        message: 'See You Again ${widget.userModel.name} . You Check Out Successfully',
        contentType: ContentType.help,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

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

  void setAttedance() {

    if(attendanceModle.checkin=='-- --  -- -- --' || attendanceModle.checkout=='' ){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){return QR_ScanScreen(attendanceModle,widget.userModel);}));
    } else{
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Hii , there!',
          message: 'Your Entry Already Present!',
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }



  }

   pleaseWaitDataLoad() {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Please Wait !',
        message: 'Your Data is Loading !',
        contentType: ContentType.warning,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }




}
