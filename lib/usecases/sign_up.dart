import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
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
}