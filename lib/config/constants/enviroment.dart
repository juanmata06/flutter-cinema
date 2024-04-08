import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String mdbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No api key';
}