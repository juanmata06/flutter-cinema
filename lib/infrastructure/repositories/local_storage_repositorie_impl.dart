import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/domain/datasources/local_storage_datasource.dart';
import 'package:flutter_cinema/domain/repositories/local_storage_repositorie.dart';

class LocalStorageRepositorieImpl extends LocalStorageRepositorie {
  final LocalStorageDataSource dataSource;
  
  LocalStorageRepositorieImpl({
    required this.dataSource
  });

  @override
  Future<bool> isMovieInFavorites(int movieId) {
    return dataSource.isMovieInFavorites(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleAsFavorite(Movie movie) {
    return dataSource.toggleAsFavorite(movie);
  }
}