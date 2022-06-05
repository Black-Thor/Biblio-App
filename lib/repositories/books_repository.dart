import 'dart:convert';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/resource/apiConstants.dart';
import 'package:bibliotrack/resource/convertion.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

List<GoogleBooks> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed["items"].map<GoogleBooks>(GoogleBooks.fromDynamic).toList();
}

class BooksRepository {
  UsersRepository usersRepository = UsersRepository();

  Future<GoogleBooks> findBookByBarcode(BookBarcode barcode) async {
    var booksFinded = await findBooksByBarcode(barcode);
    return booksFinded.first;
  }

  Future<List<GoogleBooks>> findBooksByBarcode(BookBarcode barcode) async {
    var url = Uri.parse(GoogleApiConstants.baseUrl +
        GoogleApiConstants.searchEndPoint +
        barcode.code.toString() +
        GoogleApiConstants.auth);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    }
    throw new Exception('Some arbitrary error');
  }



  Future<List<GoogleBooks>> findBooksByBarcodes(
      List<BookBarcode> barcodes) async {
    return (await Future.wait(
            barcodes.map((barcode) => findBooksByBarcode(barcode))))
        .expand((discorgList) => discorgList)
        .toList();
  }

  Future<List<GoogleBooks>> getFrenchBooks(
      List<BookBarcode> barcodeCollection) async {
    final books = await findBooksByBarcodes(barcodeCollection);

    return books.fold<List<GoogleBooks>>([], (previousBooks, currentBook) {
      final alreadyHaveVinyl = previousBooks
          .where(
              (book) => book.volumeInfo!.title == currentBook.volumeInfo!.title)
          .isNotEmpty;
      if (alreadyHaveVinyl) {
        return previousBooks;
      }
      return [
        ...previousBooks,
        currentBook,
      ];
    });
  }

  Future<List<GoogleBooks>> getFrenchBooksOfUser() async {
    final list = await BooksRepository().findBookBarcodesOfUser();
    return await getFrenchBooks(list);
  }

  Future<List<BookBarcode>> findBookBarcodesOfUser() async {
    return (await usersRepository.getCurrentUser()).bookBarcodes;
  }

  Future<void> addBookBarcode(BookBarcode barcode) async {
    return usersRepository.updateCurrentUser({
      "BookBarcode": FieldValue.arrayUnion([barcode.code])
    });
  }

  Future<void> addBookBarcodeWithCam(barcode) async {
    return usersRepository.updateCurrentUser({
      "BookBarcode": FieldValue.arrayUnion([barcode])
    });
  }

  Future<void> removeBookBarcode(BookBarcode barcode) async {
    return usersRepository.updateCurrentUser({
      "BookBarcode": FieldValue.arrayRemove([barcode.code])
    });
  }
}
