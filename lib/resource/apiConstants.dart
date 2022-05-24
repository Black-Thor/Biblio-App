import 'package:flutter_dotenv/flutter_dotenv.dart';

class VinyleApiConstants {
  static String baseUrl = 'http://api.discogs.com/database';
  static String searchEndPoint = '/search?barcode=';
  static String auth = '&token=${dotenv.env['KEY_API_VINYL']}';
  static String rule = '&page=1&per_page=1';
}

class GoogleApiConstants {
  static String baseUrl = 'https://www.googleapis.com/books/v1/';
  static String searchEndPoint = 'volumes?q=isbn:';
  static String auth = '&token=${dotenv.env['KEY_API_BOOK']}';
}
