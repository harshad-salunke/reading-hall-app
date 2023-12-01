import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyNavigationController extends GetxController{
  static MyNavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName){
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  goBack() => navigatorKey.currentState!.pop();

}