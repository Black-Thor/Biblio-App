import 'package:bibliotrack/views/bookPage/bookPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../views/Login/loginPage.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  String getUid() {
    var user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    return uid;
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future getCurrentUser() async {
    print(_auth.currentUser?.uid);
    return _auth.currentUser?.uid;
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
    print('signout');
  }

  //LOG STATUS
  Future logState(context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }
  //Password forget

  Future passwordReset(email, context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
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

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        emailReturned = _auth.currentUser?.email;
        print(_auth.currentUser);
      }
    });
    return emailReturned;
  }

  String getEmail() {
    String useremail = "empty";
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      useremail = user.email!;
    }
    return useremail;
  }
}
