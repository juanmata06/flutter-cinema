import 'package:flutter_cinema/domain/entities/movie.dart';

abstract class MoviesDatasource{
  Future<List<Movie>> getNowPlaying({int page = 1});
}