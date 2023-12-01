import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:kjcoemr_reading_hall/global/AppColors.dart';
import 'package:kjcoemr_reading_hall/pages/LoginPage/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AdminSite/AdminPage.dart';
import 'AdminSite/controllers/menu_controllers.dart';
import 'AdminSite/controllers/navigators_controllers.dart';
import 'home.dart';
import 'package:flutter/services.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC2TJQ5jQudA8Spb79Mh0WjPCDzqoV5mlo",
          authDomain: "kjei-reading-hall.firebaseapp.com",
          databaseURL: "https://kjei-reading-hall-default-rtdb.firebaseio.com",
          projectId: "kjei-reading-hall",
          storageBucket: "kjei-reading-hall.appspot.com",
          messagingSenderId: "291177894531",
          appId: "1:291177894531:web:7042338d5394a15746c1b6",
          measurementId: "G-H65ZCS27B7"
    ));
    Get.put(MyMenuController());
Get.put(MyNavigationController());
    runApp( AdminPage());

  } else {
    await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  String jsonString = sharedPreferences.getString('user_data').toString();
  UserModel userModel=UserModel('phone_number', 'name', 'roll_no', 'uid', 'join_date', 'clg_name', 'clg_year', 'clg_branch', 'gender');
  if(jsonString=='null'){
    jsonString=json.encode(userModel.toJson());
  }
  Map<String, dynamic> map = json.decode(jsonString);
  print(map);
  userModel=UserModel.fromJson(map);
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

    runApp( MyApp(userModel,initialLink));
  }
}
class MyApp extends StatefulWidget {
  UserModel userModel;
  final PendingDynamicLinkData? initialLink;
  MyApp(this.userModel,this.initialLink);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user = FirebaseAuth.instance.currentUser;

  bool isUserSingin=false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: app_bar_color, // status bar color
    ));
    return MaterialApp(
      theme: ThemeData(
        primaryColor: app_bar_color.withOpacity(1), // set app bar color
        scaffoldBackgroundColor: app_bar_color.withOpacity(1),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home:isUserSingin?Home(widget.userModel,widget.initialLink):LoginPage(),
    );
  }

  @override
  void initState() {
    if (user == null) {
      isUserSingin=false;
    }else{
      isUserSingin=true;

    }
  }

}




