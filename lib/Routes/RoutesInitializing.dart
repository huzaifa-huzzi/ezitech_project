import 'package:ezitech_project_1/Routes/Routes_name.dart';
import 'package:ezitech_project_1/View/Admin%20Panel.dart';
import 'package:ezitech_project_1/View/AttendanceMarking.dar.dart';
import 'package:ezitech_project_1/View/LoginScreen.dart';
import 'package:ezitech_project_1/View/SignupScree.dart';
import 'package:ezitech_project_1/View/Students%20seeingscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes{

  static appRoutes() => [
    GetPage(name: RouteName.loginScreen, page: () => LoginScreen()),
    GetPage(name: RouteName.signupScreen, page: () => SignUpScreen()),
    //view
    GetPage(name: RouteName.attendanceMarking, page: () =>const  AttendanceMarking()),
    GetPage(name: RouteName.adminPanel, page: () => AdminPanel()),
    GetPage(name: RouteName.studentSeeing, page: () => StudentAttendanceScreen()),
  ];

}