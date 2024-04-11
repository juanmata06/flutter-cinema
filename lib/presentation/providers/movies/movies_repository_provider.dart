import 'package:flutter_cinema/infrastructure/datasources/movies_datasource.dart';
import 'package:flutter_cinema/infrastructure/rempostory/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repo de solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImplementation(MovieDbDatasource());
});