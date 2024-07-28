import 'package:ezitech_project_1/Routes/Routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),backgroundColor: Colors.red,centerTitle: true,automaticallyImplyLeading: false,),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                       Get.toNamed(RouteName.adminPanel);
                      },
                      child: const Text('Login',style: TextStyle(color: Colors.red),),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: (){
                          Get.toNamed(RouteName.signupScreen);
                      },
                      child:const  Text.rich(
                        TextSpan(
                          style: TextStyle(),
                          children: [
                            TextSpan(
                                text: 'Don\'t have an account? Sign Up ',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ) ,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      );
  }
}
