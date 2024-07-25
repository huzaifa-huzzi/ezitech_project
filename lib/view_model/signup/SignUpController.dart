import 'package:ezitech_project_1/Routes/Routes_name.dart';
import 'package:ezitech_project_1/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Session/SessionManager.dart';

class SignUpController extends GetxController {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref().child('user');

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final emailFocus = FocusNode().obs;
  final passwordFocus = FocusNode().obs;

  RxBool loading = false.obs;

  void signUpFtn(String email, String password, BuildContext context) async {
    loading.value = true;

    try {
      if (password.length < 6) {
        throw Exception();
      }

      await auth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) {
        SessionManager().userId = value.user!.uid.toString();
        Utils.snackBar('Signin'.tr, 'Signinsuccessful'.tr);
         Get.toNamed(RouteName.attendanceMarking);
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'returnSecureToken': true,
        }).then((_) {
          Utils.snackBar('_Registration'.tr, '_Registration successful'.tr);
          loading.value = false;
        }).catchError((error) {
          Utils.toastMessage(error.toString());
          loading.value = false;
        });
      }).catchError((error) {
        Utils.toastMessage(error.toString());
        loading.value = false;
      });
    } catch (e) {

    }


  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.value.dispose();
    passwordFocus.value.dispose();
    super.onClose();
  }
}