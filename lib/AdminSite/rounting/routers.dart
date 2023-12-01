import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/AdminSite/layout.dart';
import 'package:kjcoemr_reading_hall/AdminSite/rounting/routes.dart';

import '../pages/Overview/overview.dart';
import '../pages/Students/students.dart';
import '../pages/dailyAttendance/daily_attendance.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverViewPage());
    case driversPageRoute:
      return _getPageRoute(DailyAttendancePage());
    case clientsPageRoute:
      return _getPageRoute(StudentsPage());
    case homePageRoute:
      return _getPageRoute(SiteLayout());

    default:
      return _getPageRoute(OverViewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}