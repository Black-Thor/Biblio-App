import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase {
    final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}