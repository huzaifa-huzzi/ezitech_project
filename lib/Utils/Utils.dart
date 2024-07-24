


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils{

  // Focus for textFormField;
  static void fieldFocusChange(BuildContext context,FocusNode current,FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  // toastMessage
  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red

    );
  }

//snackBar Message
  static snackBar(String title,String message){
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );

  }




}