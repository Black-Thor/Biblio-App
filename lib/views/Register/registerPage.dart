import 'package:bibliotrack/usecases/sign_up.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/firestore.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

final email = TextEditingController();
final password = TextEditingController();
final nickName = TextEditingController();

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
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
                    controller: email,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0092A2)))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0092A2)))),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: nickName,
                    decoration: const InputDecoration(
                        labelText: 'NICK NAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0092A2)))),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      width: double.infinity,
                      height: 45,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Color(0xff0092A2),
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookPage()));
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              SignUpUseCase()
                                  .signUp(
                                      email: email.text,
                                      password: password.text)
                                  .then((result) async {
                                if (result == null) {
                                  var user =
                                      await FirebaseAuth.instance.currentUser!;
                                  var uid = user.uid;
                                  print(uid);
                                  CollectionHelper().addUser(
                                      uid: uid,
                                      username: nickName.text.toString());
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookPage()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      result,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ));
                                }
                              });
                            },
                            child: Text(
                              'SIGNUP',
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
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}
