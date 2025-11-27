import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  //api_key
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No se encontro THE_MOVIEDB_KEY';
  //url_base
  static String theMovieDbUrl =
      dotenv.env['THE_MOVIEDB_URL'] ?? 'No se encontro THE_MOVIEDB_URL';
  //url_image
  static String theMovieDbImage =
      dotenv.env['THE_MOVIEDB_IMAGE_URL'] ?? 'No se encontro THE_MOVIEDB_URL';
}
