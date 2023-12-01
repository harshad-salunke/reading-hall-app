import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kjcoemr_reading_hall/Models/UserModle.dart';

class RegistrationController{

  TextEditingController phone_numberController=TextEditingController();
  TextEditingController full_nameController=TextEditingController();
  TextEditingController roll_noController=TextEditingController();
  TextEditingController college_nameController=TextEditingController();
  TextEditingController college_yearController=TextEditingController();
  TextEditingController college_branchController=TextEditingController();
  TextEditingController gender_Controller=TextEditingController();

  bool validation(){
    if(phone_numberController.text=="" || phone_numberController.text.length<10){
      Fluttertoast.showToast(
          msg: "Please Enter Valid Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;

    }
    if(full_nameController.text=="" ){
      Fluttertoast.showToast(
          msg: "Please Enter Full Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;

    }
    if(roll_noController.text=="" ){
      Fluttertoast.showToast(
          msg: "Please Enter Roll No",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;

    }
    if(college_nameController.text=="" ){
      Fluttertoast.showToast(
          msg: "Please Select College Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;
    }

    if(college_yearController.text=="" ){
      Fluttertoast.showToast(
          msg: "Please Select College year",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;
    }
    if(college_branchController.text=="" ){
      Fluttertoast.showToast(
          msg: "Please Select College Branch",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;
    }

    if(gender_Controller.text=="" ){
      Fluttertoast.showToast(
          msg: "Please Select Gender",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;
    }

    return true;
  }

  UserModel getUserData(){
    return UserModel(phone_numberController.text, full_nameController.text, roll_noController.text, "uid", "", college_nameController.text, college_yearController.text, college_branchController.text, gender_Controller.text);
  }

}