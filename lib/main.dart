import 'package:ezitech_project_1/Routes/RoutesInitializing.dart';
import 'package:ezitech_project_1/View/DashBoard/DashBoardScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ezitech Project',
      home:const  DashboardScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}


