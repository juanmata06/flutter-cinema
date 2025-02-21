import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cinema/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_cinema/infrastructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviesDbDatasource());
});
