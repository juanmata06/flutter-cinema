import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String theMovieDbKey = dotenv.env['MOVIEDB_KEY'] ?? 'No key.';
  static String movieDbBaseUrl = dotenv.env['MOVIEDB_BASE_URL'] ?? 'No base url';
  static String movieDbApiLanguage = dotenv.env['MOVIEDB_LANGUAGE'] ?? 'No languaje';
}
