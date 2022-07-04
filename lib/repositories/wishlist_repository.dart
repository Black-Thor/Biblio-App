import 'dart:math';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/books_repository.dart';
import 'package:bibliotrack/resource/convertion.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistRepository {
  UsersRepository usersRepository = UsersRepository();

  Future<List<BookBarcode>> getSavedBookInWishlistOfCurrentUser() async {
    return (await usersRepository.getCurrentUser()).bookBarcodesWished;
  }

  Future<void> addBookInWishlistFromBarcode(BookBarcode barcode) async {
    return usersRepository.updateCurrentUser({
      "BookWish": FieldValue.arrayUnion([barcode.code])
    });
  }

  Future<void> deleteBookFromWishlist(barcode) async {
    return usersRepository.updateCurrentUser({
      "BookWish": FieldValue.arrayRemove([barcode])
    });
  }

  Future<void> deleteVinylsFromWishlist(barcode) {
    return usersRepository.updateCurrentUser({
      "VinylesWish": FieldValue.arrayRemove([barcode])
    });
  }

  Future<void> addVinylInWishlistFromBarcode(
      VinylBarcode vinylBarcode, context) async {
    return usersRepository.updateCurrentUser({
      "VinylesWish": FieldValue.arrayUnion([vinylBarcode.code])
    });
  }

  Future addBookToListOfBook(BookBarcode barcode, context) async {
    return usersRepository.updateCurrentUser({
      "BookBarcode": FieldValue.arrayUnion([barcode.code])
    });
  }

  Future<void> addVinylBarcode(barcode) {
    return usersRepository.updateCurrentUser({
      "VinylesBarcode": FieldValue.arrayUnion([barcode])
    });
  }

  Future<void> addVinylBarcodeWithCam(barcode) async {
    return usersRepository.updateCurrentUser({
      "VinylesWish": FieldValue.arrayUnion([barcode])
    });
  }

  Future<void> addBookBarcodeWithCam(barcode) async {
    return usersRepository.updateCurrentUser({
      "BookWish": FieldValue.arrayUnion([barcode])
    });
  }

  Future<List<VinylBarcode>> wishedVinylFromBarcode() async {
    return (await usersRepository.getCurrentUser()).vinylBarcodesWished;
  }
}
