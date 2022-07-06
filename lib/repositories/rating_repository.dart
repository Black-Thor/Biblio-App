import 'package:cloud_firestore/cloud_firestore.dart';

class RatingRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getRatingOfBook(identifier) async {
    return _store.collection("Rating").doc(identifier).get();
  }
}
