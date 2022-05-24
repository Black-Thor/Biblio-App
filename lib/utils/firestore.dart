import 'package:bibliotrack/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _store = FirebaseFirestore.instance;

class CollectionHelper {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future userData({required String uid, required String username}) async {
    return users
        .add({
          'uid': uid,
          'username': username,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future addUser({required uid, required String username}) {
    return users
        .doc(uid)
        .set({'uid': uid, 'username': username})
        .then((value) => print("data Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future getUser(username) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: '${username}')
        .get();
  }

}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = _store.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("User does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print(Text("Full Name: ${data['uid']} ${data['username']}"));
          return Text("${data['username']}");
        }

        return Text("loading");
      },
    );
  }
}

class finduser extends StatelessWidget {
  final String username;

  finduser(this.username);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = _store.collection('users');

    return FutureBuilder(
      future: users.where('username', isEqualTo: '${username}').get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("wrong");
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("doesnt exist");
          return Text("User does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data! as Map<String, dynamic>;
          print(snapshot.data!);
          return Text("${data}");
        }

        return Text("loading");
      },
    );
  }
}
