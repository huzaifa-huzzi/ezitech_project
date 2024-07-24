import 'package:ezitech_project_1/view_model/LoginScreen/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final controller = Get.put(LoginController());

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
    //attempt login

    controller.login(email, password, context);
    }
    },
    child:const  Text('Login'),
    ),
      const  SizedBox(height: 10),
     const  Text.rich(
        TextSpan(
            style: TextStyle(),
            children: [
              TextSpan(
                text: 'Dont have an account  ? Sign Up ',
                style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Colors.black),
              )
            ]
        ),
      ),
    ],
    ),
    ),
    );
  })),
    );
  }
}
