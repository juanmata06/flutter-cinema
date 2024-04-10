import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String mdbKey = dotenv.env['MOVIEDB_KEY'] ?? 'No api key';
  static String baseUrl = dotenv.env['MOVIEDB_BASE_URL'] ?? 'No base url';
  static String apiLanguage = dotenv.env['MOVIEDB_LANGUAGE'] ?? 'No languaje';
}