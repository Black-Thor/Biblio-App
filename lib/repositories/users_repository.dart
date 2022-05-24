import 'package:bibliotrack/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UsersRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  String getEmail() {
    String useremail = "empty";
    final user = _auth.currentUser;
    if (user != null) {
      useremail = user.email!;
    }
    return useremail;
  }

  void updateProfile(Element) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .update({'profilePicture': Element}).then((_) {
      print("success!");
    });
  }

  Future getProfilepic(username) {
    return _store
        .collection('users')
        .where('username', isEqualTo: '${username}')
        .get();
  }
}
