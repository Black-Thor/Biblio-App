import 'dart:math';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/usecases/convertion.dart';
import 'package:bibliotrack/usecases/message_scaffold.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WishlistRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<List<BookBarcode>> WishedBookFromBarcode() async {
    final value = await _store
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    print("value of instance : ${value.data()!["BookWish"]}");
    final barcodes = value.data()!["BookWish"] as List<dynamic>;
    return barcodes.map(BookBarcode.fromDynamic).toList();
  }

  Future<List<VinylBarcode>> WishedVinylFromBarcode() async {
    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    print("value of instance vinyles: ${value.data()!["VinylesWish"]}");

    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    return barcodes.map(VinylBarcode.fromDynamic).toList();
  }

  void onPressedDeleteVinyls(elemets) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .update({
      "VinylesWish": FieldValue.arrayRemove([elemets])
    }).then((_) {
      print("success!");
    });
  }

  void onPressedAddBook(elemets, context) async {
    int data = ConvertionUseCase().ChangeStringToInt(elemets);
    final value = await _store
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    final barcodes = value.data()!["BookWish"] as List<dynamic>;

    if (barcodes.contains(data)) {
      MessageScaffold().Scaffold(context, 'Already in wish list');
    } else {
      _store.collection("users").doc(AuthenticationHelper().getUid()).update({
        "BookWish": FieldValue.arrayUnion([data])
      }).then((_) {
        print("success!");
        MessageScaffold().Scaffold(context, "Added to WishList");
      });
    }
  }

  void onPressedDeleteBook(elemets, context) {
    _store.collection("users").doc(AuthenticationHelper().getUid()).update({
      "BookWish": FieldValue.arrayRemove([elemets])
    }).then((_) {
      MessageScaffold().Scaffold(context, "Added to WishList");
    });
  }

  void onPressedAddVinyl(elemets, context) async {
    final value = await _store
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();

    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    var myInt = int.parse(elemets[0]);
    assert(myInt is int);
    // int data = ConvertionUseCase().ChangeListToInt(elemets[0]);

    if (barcodes.contains(elemets)) {
      MessageScaffold().Scaffold(context, 'Already in wish list');
    } else {
      print(myInt);
      _store.collection("users").doc(AuthenticationHelper().getUid()).update({
        "VinylesWish": FieldValue.arrayUnion([myInt])
      }).then((_) {
        print("success!");
        MessageScaffold().Scaffold(context, "Added to WishList");
      });
    }
  }
}
