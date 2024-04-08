import 'package:flutter_cinema/domain/entities/movie.dart';

abstract class MoviesRepositoies{
  Future<List<Movie>> getNowPlaying({int page = 1});
}