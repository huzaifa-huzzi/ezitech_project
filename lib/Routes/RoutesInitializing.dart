import 'package:ezitech_project_1/Routes/Routes_name.dart';
import 'package:ezitech_project_1/View/DashBoard/DashBoardScreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes{

  static appRoutes() => [
    GetPage(name: RouteName.dashboardScreen, page: () =>const DashboardScreen()),
    //view

  ];

}