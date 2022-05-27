import 'dart:math';

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
    final value = await usersRepository.getCurrentUser();
    final barcodes = value.data()!["BookWish"] as List<dynamic>;
    return barcodes.map(BookBarcode.fromDynamic).toList();
  }

  Future<List<VinylBarcode>> wishedVinylFromBarcode() async {
    final value = await usersRepository.getCurrentUser();
    // print("value of instance vinyles: ${value.data()!["VinylesWish"]}");
    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    return barcodes.map(VinylBarcode.fromDynamic).toList();
  }

  void deleteVinylsFromWishlist(context, elemets) {
    usersRepository.updateCurrentUser({
      "VinylesWish": FieldValue.arrayRemove([elemets])
    }).then((_) {
      MessageScaffold().warningSnackbar(context, "👋 Adieu petit vinyle",
          "Ce vinyle à été retirer de votre Wishlist");
    });
  }

  void onPressedAddBook(elemets, context) async {
    int data = Convertion().ChangeStringToInt(elemets);
    final value = await usersRepository.getCurrentUser();
    final barcodes = value.data()!["BookBarcode"] as List<dynamic>;

    if (barcodes.contains(data)) {
      MessageScaffold()
          .errorSnackbar(context, "Désolé 🤒", 'Vous avez déja ce livre');
    } else {
      usersRepository.updateCurrentUser({
        "BookBarcode": FieldValue.arrayUnion([data])
      }).then((_) {
        print("success!");
        MessageScaffold().successSnackbar(context, "Bonne lecture 🥰 ",
            "Votre nouveaux livre à été ajouté à la bibliothéque");
        usersRepository.updateCurrentUser({
          "BookWish": FieldValue.arrayRemove([data])
        });
      });
    }
  }

  Future<void> addBookInWishlistFromBarcode(BookBarcode barcode) async {
    GoogleBooks book = await BooksRepository().findBookByBarcode(barcode);

    return usersRepository.updateCurrentUser({
      "BookWish": FieldValue.arrayUnion(
          [Convertion().ChangeStringToInt(book.getISBN13())])
    });
  }

  Future<void> deleteBookFromWishlist(barcode) async {
    return usersRepository.updateCurrentUser({
      "BookWish":
          FieldValue.arrayRemove([Convertion().ChangeStringToInt(barcode)])
    });
  }

  void onPressedAddVinyl(elemets, context) async {
    final value = await usersRepository.getCurrentUser();
    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    int barcodeForWishlist = Convertion().ChangeListToInt(elemets[0]);

    if (barcodes.contains(elemets)) {
      MessageScaffold()
          .errorSnackbar(context, "Désolé 🤒", 'Vous avez déja ce vinyle');
    } else {
      print(barcodeForWishlist);
      usersRepository.updateCurrentUser({
        "VinylesWish": FieldValue.arrayUnion([barcodeForWishlist])
      }).then((_) {
        print("success!");
        MessageScaffold().successSnackbar(context, "Bonne écoute 🥰 ",
            "Votre nouveaux Vinyle à été ajouté à la bibliothéque");
      });
    }
  }
}
