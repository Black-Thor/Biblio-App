import 'dart:convert';
import 'dart:developer';

import 'package:bibliotrack/models/userModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/resource/apiConstants.dart';
import 'package:http/http.dart' as http;

List<Discogs> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody);

  return parsed["results"]
      .map<Discogs>((json) => Discogs.fromJson(json))
      .toList();
}

class ApiServiceV {
  Future<List<Discogs>?> getVinyle() async {
    var url = Uri.parse(
        "http://api.discogs.com/database/search?barcode=050087310882&token=ngMzonctIkEONyHkiNGQOpPsgVbVDWBHxSrGMMPV");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return parseProducts(response.body);
    }
  }

  Future<List<Discogs>?> getFrenchVinyls() async {
    final vinyls = await getVinyle();

    return vinyls?.fold<List<Discogs>>([], (previousVinyls, currentVinyl) {
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
