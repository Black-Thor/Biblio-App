import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../views/Login/loginPage.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getUid() {
    var user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    return uid;
  }

  Future getCurrentUser() async {
    print(_auth.currentUser?.uid);
    return _auth.currentUser?.uid;
  }



  //Password forget
  Future passwordReset(email, context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          "A email was send for Reset",
          style: TextStyle(fontSize: 16),
        ),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ));
    }
  }

  Future Logged(context) async {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BookPage()));
      }
    });
  }

  Future userInfo() async {
    String? emailReturned;

    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        emailReturned = _auth.currentUser?.email;
        print(_auth.currentUser);
      }
    });
    return emailReturned;
  }


}
