import 'dart:convert';
import 'dart:developer';

import 'package:bibliotrack/models/userModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/resource/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

List<Discogs> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody);

  return parsed["results"]
      .map<Discogs>((json) => Discogs.fromJson(json))
      .toList();
}

class ApiServiceVinyle {
  Future<List<Discogs>> getVinyle(barcode) async {
    var url = Uri.parse(VinyleApiConstants.baseUrl +
        VinyleApiConstants.searchEndPoint +
        barcode.toString() +
        VinyleApiConstants.auth);

    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } 

    throw new Exception('Some arbitrary error'); 
  }

  Future<List<Discogs>> getFrenchVinyls(barcode) async {
    final vinyls = await getVinyle(barcode);

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
}