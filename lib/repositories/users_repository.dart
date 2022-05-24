import 'package:firebase_auth/firebase_auth.dart';


class UsersRepository {
    final FirebaseAuth _auth = FirebaseAuth.instance;

  String getEmail() {
    String useremail = "empty";
    final user = _auth.currentUser;
    if (user != null) {
      useremail = user.email!;
    }
    return useremail;
  }
}