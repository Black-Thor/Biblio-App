import 'dart:developer';

import 'package:bibliotrack/usecases/sign_in.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/views/Login/forgetPasswordLink.dart';
import 'package:bibliotrack/views/Login/input.dart';
import 'package:bibliotrack/views/Login/emailTextField.dart';
import 'package:bibliotrack/views/Login/forgetPassword.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import '../Register/registerPage.dart';
import 'passwordTextField.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    // TODO: rename this to AuthenticationGuard.redirectIfUserIsLogged()
    AuthenticationHelper().Logged(context);
  }

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: deviceHeight * 0.30,
            child: logo,
          ),
          Container(
            height: deviceWidth * 0.90,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...welcome(constraints),
                  Input(
                      constraints: constraints,
                      textField:
                          EmailTextField(controller: emailTextController)),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),
                  Input(
                      constraints: constraints,
                      textField: PasswordTextField(
                        controller: passwordTextController,
                      )),
                  const ForgetPasswordLink(),
                  Container(
                    width: double.infinity,
                    height: constraints.maxHeight * 0.11,
                    margin: EdgeInsets.only(
                      top: constraints.maxHeight * 0.01,
                    ),
                    child: ElevatedButton(
                      onPressed: () => submitLoginForm(emailTextController.text,
                          passwordTextController.text, context),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff0092A2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  accessRegisterForm(context),
                ],
              );
            }),
          )
        ],
      ),
    ));
  }
}

final logo = Container(
    child: Container(
  decoration: const BoxDecoration(
      image: DecorationImage(
    image: AssetImage('assets/images/Logo.png'),
  )),
));

welcome(constraints) {
  return [
    const Text(
      'Login Now',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: constraints.maxHeight * 0.01,
    ),
    const Text('Please enter the details below to continue'),
    SizedBox(
      height: constraints.maxHeight * 0.08,
    ),
  ];
}

submitLoginForm(String email, String password, BuildContext context) {
  SignInUseCase().signIn(email: email, password: password).then((result) {
    if (result == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BookPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          result,
          style: TextStyle(fontSize: 16),
        ),
      ));
    }
  });
}

accessRegisterForm(context) {
  return RichText(
      text: TextSpan(
          text: 'Don\'t have an Account ',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          children: [
        TextSpan(
            text: 'Register',
            style: const TextStyle(
              color: Color(0xff0092A2),
              fontSize: 18,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationPage()));
              }),
      ]));
}
