import 'package:bibliotrack/views/Login/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetButton {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
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
}