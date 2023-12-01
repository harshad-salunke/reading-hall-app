import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:kjcoemr_reading_hall/AdminSite/pages/authentication/authentication.dart';

import 'constants/style.dart';
import 'layout.dart';
class AdminPage extends StatefulWidget {


  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  User? user = FirebaseAuth.instance.currentUser;

  bool isUserSingin=false;
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',

      home: AuthenticationPage(),

    );
  }



}