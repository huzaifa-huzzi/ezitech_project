import 'package:ezitech_project_1/view_model/signup/SignUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:const  Text('Login')),
      body: SafeArea(
          child: Obx((){
             return Padding(
               padding: const EdgeInsets.all(16.0),
               child: Form(
                 key: _formKey,
                 child: Column(
                   children: [
                     TextFormField(
                       controller: _emailController,
                       decoration: InputDecoration(labelText: 'Email'),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter your email';
                         }
                         return null;
                       },
                     ),
                     const  SizedBox(height: 10),
                     TextFormField(
                       controller: _passwordController,
                       decoration: InputDecoration(labelText: 'Password'),
                       obscureText: true,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter your password';
                         }
                         return null;
                       },
                     ),
                     const  SizedBox(height: 20),
                     ElevatedButton(
                       onPressed: () {
                         if (_formKey.currentState!.validate()) {
                           String email = controller.emailController.value.text;
                           String password = controller.passwordController.value.text;
                           controller.signUpFtn(email, password, context );
                         }
                       },
                       child:const  Text('Signup'),
                     ),
                   ],
                 ),
               ),
             );
          }) )


    );
  }
}
