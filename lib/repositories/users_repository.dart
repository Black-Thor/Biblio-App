import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:flutter/material.dart';
import '../views/Login/loginPage.dart';

class UsersRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  Future getCurrentUser() async {
    return (await _getCurrentUserDocumentReference()).get();
  }

  Future<void> updateCurrentUser(Map<String, Object?> data) async {
    return (await _getCurrentUserDocumentReference()).update(data);
  }

  // TODO: rename in getEmailOfCurrentUser, getCurrentUserEmail?
  String getCurrentUserEmail() {
    String useremail = "empty";
    final user = _auth.currentUser;
    if (user != null) {
      useremail = user.email!;
    }
    return useremail;
  }

  void updateProfile(Element) {
    updateCurrentUser({'profilePicture': Element}).then((_) {
      print("success!");
    });
  }

  Future addUser({required uid, required String username}) {
    return _store
        .doc(uid)
        .set({'uid': uid, 'username': username})
        .then((value) => print("data Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // Future getUser(username) async {
  //   return _store
  //       .collection("users")
  //       .where('username', isEqualTo: '${username}')
  //       .get();
  // }

  Future<DocumentSnapshot> getUserById(identifier) async {
    return _store.collection("users").doc(identifier).get();
  }

  Future<DocumentReference<Object?>> _getCurrentUserDocumentReference() async {
    return await _store.collection("users").doc(getCurrentUserId());
  }
}

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
