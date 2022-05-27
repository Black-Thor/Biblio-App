import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/usecases/passwordReset.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgetPassword extends StatefulWidget {
  forgetPassword({Key? key}) : super(key: key);

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  final emailToReset = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 298.0, 1.0, 0.0),
                      child: Text(
                        '?',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0092A2)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailToReset,
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0092A2)))),
                      ),
                      SizedBox(height: 50.0),
                      Container(
                          width: double.infinity,
                          height: 45,
                          // margin: EdgeInsets.only(
                          //   top: constraints.maxHeight * 0.01,
                          // ),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Color(0xff0092A2),
                            elevation: 7.0,
                            child: ElevatedButton(
                              onPressed: () {
                                PasswordResetButton()
                                    .passwordReset(emailToReset.text, context);
                              },
                              child: Text(
                                'Reset Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff0092A2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: goBackbutton(context),
                      ),
                    ],
                  )),
            ]));
  }
}

Container goBackbutton(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 1.0),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0)),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Center(
        child: Text('Go Back',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
      ),
    ),
  );
}
