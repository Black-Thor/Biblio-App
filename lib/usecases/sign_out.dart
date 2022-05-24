import 'package:firebase_auth/firebase_auth.dart';

class SignOutUseCase{
    final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut() async {
    await _auth.signOut();
    print('signout');
  }
}