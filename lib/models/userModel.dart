import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticatedUser {
  final String uid;
  final String username;
  final List<BookBarcode> bookBarcodes;
  final List<BookBarcode> bookBarcodesWished;
  final List<VinylBarcode> vinylBarcodes;
  final List<VinylBarcode> vinylBarcodesWished;

  AuthenticatedUser(
    this.uid,
    this.username,
    this.bookBarcodes,
    this.bookBarcodesWished,
    this.vinylBarcodes,
    this.vinylBarcodesWished,
  );

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
      json["uid"],
      json["username"],
      (json["BookBarcode"] as Iterable<String>)
          .map(BookBarcode.fromString)
          .toList(),
      (json["BookWish"] as Iterable<String>)
          .map(BookBarcode.fromString)
          .toList(),
      (json["VinylesBarcode"] as Iterable<String>)
          .map(VinylBarcode.fromString)
          .toList(),
      (json["VinylesWish"] as Iterable<String>)
          .map(VinylBarcode.fromString)
          .toList(),
    );
  }

  factory AuthenticatedUser.fromDocumentSnapshot(DocumentSnapshot document) {
    return AuthenticatedUser(
      document["uid"],
      document["username"],
      (document["BookBarcode"] as List<dynamic>)
          .map(BookBarcode.fromDynamic)
          .toList(),
      (document["BookWish"] as List<dynamic>)
          .map(BookBarcode.fromDynamic)
          .toList(),
      (document["VinylesBarcode"] as List<dynamic>)
          .map(VinylBarcode.fromDynamic)
          .toList(),
      (document["VinylesWish"] as List<dynamic>)
          .map(VinylBarcode.fromDynamic)
          .toList(),
    );
  }
}
