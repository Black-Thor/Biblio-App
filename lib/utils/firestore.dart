import 'package:bibliotrack/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class collectionHelper {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future userData({required String uid, required String username}) async {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'uid': uid, // John Doe
          'username': username, // Stokes and Sons
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

  Future getUser({required uid}) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
  }

  Future getDoc() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(AuthenticationHelper().getUid())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document data: ${documentSnapshot['username']}');
        return documentSnapshot['username'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
