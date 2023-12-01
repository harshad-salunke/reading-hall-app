// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_database/firebase_database.dart';






class FirebaseHandler extends ChangeNotifier {
  late FirebaseAuth _auth;
  late String _verificationID;
  bool isSignIn = false;
  String phoneNo = "", otp = "";
  int? _resendToken;
  late final SharedPreferences prefs ;



  //Method to detect live auth changes such as user sign in and sign out


  Future<void> sendOTP(BuildContext context) async {
    try {
      prefs =  await SharedPreferences.getInstance();
      _auth=FirebaseAuth.instance;
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneNo.trim()}",
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) async {

          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Oh Snap!',
              message:
              'Phone number verification failed.\n${e.message}',
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

        },
        codeSent: (String verificationId, int? resendToken) {
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Hii, there!',
              message:
              'OTP has been sent successfully.',
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          _verificationID = verificationId;
          _resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationID = verificationId;
        },
        forceResendingToken: _resendToken,
      );
      toggleOTPView();
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Hii, there!',
          message:
          'Phone number verification failed.\n${e.message}',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      notifyListeners();
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'hii, there!',
          message:
          'Phone number verification failed.\n${e}',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    }
  }
  bool _showProgress = false;
  Widget? _progressIndicator;

  bool get showProgress => _showProgress;

  void startProgress(BuildContext context) {
    _showProgress = true;
    _progressIndicator = CircularProgressIndicator();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _progressIndicator!,
                SizedBox(height: 16),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }
  void stopProgress(BuildContext context) {
    _showProgress = false;
    if (_progressIndicator != null) {
      Navigator.of(context).pop();
      _progressIndicator = null;
    }
  }

  Future<void> verifyOTP(Function(bool error) callback,UserModel userModel,bool isLogin) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationID, smsCode: otp);
      await _auth.signInWithCredential(credential).then((value){
        if(!isLogin){
          userModel.uid=FirebaseAuth.instance.currentUser!.uid;
          SaveUserData(callback, userModel);
        }else{
          callback(false);
        }

      });

    } on FirebaseAuthException catch (e) {
      callback(true);

      Fluttertoast.showToast(
          msg: "Phone number verification failed.\n${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      notifyListeners();
    }
  }
  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM y').format(now);

    return formattedDate;
  }

  void SaveUserData(Function(bool err) callback,UserModel userModel) async{
    userModel.join_date=_getCurrentDate();

    String personJson = json.encode(userModel.toJson());
    await prefs.setString('user_data',personJson );

    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    Map<String, dynamic> data = userModel.toJson();
    String path='Students/${userModel.phone_number}';
    dbRef.child(path).set(data).then((value) {
        callback(false);
    }).catchError((error) {
      callback(true);
      signOut();
      print('Failed to push data to the database: $error');
    });
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void toggleSignIn() {
    isSignIn = !isSignIn;
    notifyListeners();
  }

  void toggleOTPView() {

  }
}
