import 'dart:math';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/resource/convertion.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WishlistRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  UsersRepository usersRepository = new UsersRepository();

  Future<List<BookBarcode>> WishedBookFromBarcode() async {
    final value = await usersRepository.getCurrentUser();
    // print("value of instance : ${value.data()!["BookWish"]}");
    final barcodes = value.data()!["BookWish"] as List<dynamic>;
    return barcodes.map(BookBarcode.fromDynamic).toList();
  }

  Future<List<VinylBarcode>> WishedVinylFromBarcode() async {
    final value = await usersRepository.getCurrentUser();
    // print("value of instance vinyles: ${value.data()!["VinylesWish"]}");
    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    return barcodes.map(VinylBarcode.fromDynamic).toList();
  }

  void onPressedDeleteVinyls(elemets) {
    usersRepository.updateCurrentUser({
      "VinylesWish": FieldValue.arrayRemove([elemets])
    }).then((_) {
      print("success!");
    });
  }

  void onPressedAddBook(elemets, context) async {
    int data = Convertion().ChangeStringToInt(elemets);
    final value = await usersRepository.getCurrentUser();
    final barcodes = value.data()!["BookWish"] as List<dynamic>;

    if (barcodes.contains(data)) {
      MessageScaffold().Scaffold(context, 'Already in wish list');
    } else {
      usersRepository.updateCurrentUser({
        "BookWish": FieldValue.arrayUnion([data])
      }).then((_) {
        print("success!");
        MessageScaffold().Scaffold(context, "Added to WishList");
      });
    }
  }

  void onPressedDeleteBook(elemets, context) {
    usersRepository.updateCurrentUser({
      "BookWish": FieldValue.arrayRemove([elemets])
    }).then((_) {
      MessageScaffold().Scaffold(context, "Added to WishList");
    });
  }

  void onPressedAddVinyl(elemets, context) async {
    final value = await usersRepository.getCurrentUser();
    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    int barcodeForWishlist = Convertion().ChangeListToInt(elemets[0]);

    if (barcodes.contains(elemets)) {
      MessageScaffold().Scaffold(context, 'Already in wish list');
    } else {
      print(barcodeForWishlist);
      usersRepository.updateCurrentUser({
        "VinylesWish": FieldValue.arrayUnion([barcodeForWishlist])
      }).then((_) {
        print("success!");
        MessageScaffold().Scaffold(context, "Added to WishList");
      });
    }
  }
}
