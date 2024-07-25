import 'package:ezitech_project_1/Routes/Routes_name.dart';
import 'package:ezitech_project_1/View/Attendance%20marking.dart';
import 'package:ezitech_project_1/View/LoginScreen.dart';
import 'package:ezitech_project_1/View/SignupScree.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes{

  static appRoutes() => [
    GetPage(name: RouteName.loginScreen, page: () => LoginScreen()),
    GetPage(name: RouteName.signupScreen, page: () => SignUpScreen()),
    //view
    GetPage(name: RouteName.attendanceMarking, page: () =>const  AttendanceMarking()),
  ];

}