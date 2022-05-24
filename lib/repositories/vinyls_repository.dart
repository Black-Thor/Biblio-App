import 'dart:convert';
import 'dart:developer';

import 'package:bibliotrack/models/userModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/resource/apiConstants.dart';
import 'package:bibliotrack/usecases/convertion.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

List<Discogs> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody);

  return parsed["results"]
      .map<Discogs>((json) => Discogs.fromJson(json))
      .toList();
}

final FirebaseFirestore _store = FirebaseFirestore.instance;

class VinylsRepository {
  Future<List<Discogs>> findVinylsByBarcode(VinylBarcode barcode) async {
    var url = Uri.parse(VinyleApiConstants.baseUrl +
        VinyleApiConstants.searchEndPoint +
        barcode.code.toString() +
        VinyleApiConstants.auth +
        VinyleApiConstants.rule);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    }

    throw new Exception('Some arbitrary error');
  }

  Future<List<Discogs>> findVinylsByBarcodes(
      List<VinylBarcode> barcodes) async {
    return (await Future.wait(
            barcodes.map((barcode) => findVinylsByBarcode(barcode))))
        .expand((discorgList) => discorgList)
        .toList();
  }

  Future<List<Discogs>> getFrenchVinyls(
      List<VinylBarcode> barcodeCollection) async {
    final vinyls = await findVinylsByBarcodes(barcodeCollection);

    return vinyls.fold<List<Discogs>>([], (previousVinyls, currentVinyl) {
      final alreadyHaveVinyl = previousVinyls
          .where((vinyl) => vinyl.title == currentVinyl.title)
          .isNotEmpty;
      if (alreadyHaveVinyl) {
        return previousVinyls;
      }

      return [
        ...previousVinyls,
        currentVinyl,
      ];
    });
  }

  Future<List<VinylBarcode>> findVinylBarcodesOfUser() async {
    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    print("value of instance : ${value.data()!["VinylesBarcode"]}");

    final barcodes = value.data()!["VinylesBarcode"] as List<dynamic>;
    return barcodes.map(VinylBarcode.fromDynamic).toList();
  }

  Future<List<Discogs>> getFrenchVinylsOfUser() async {
    final list = await findVinylBarcodesOfUser();
    return await getFrenchVinyls(list);
  }

  Future<void> addVinylBarcode(barcode) {
    return _store.collection("users").doc(AuthenticationHelper().getUid()).update({
      "VinylesBarcode": FieldValue.arrayUnion([
        ConvertionUseCase().ChangeStringToInt(barcode)
      ])
    });
  }

  Future<void> removeVinylBarcode(barcode) {
    return _store.collection("users").doc(AuthenticationHelper().getUid()).update({
      "VinylesBarcode": FieldValue.arrayRemove([
        ConvertionUseCase().ChangeStringToInt(barcode)
      ])
    });
  }
}
