import 'package:flutter_cinema/domain/entities/movie.dart';

abstract class LocalStorageDataSource {
  Future<void> toggleAsFavorite(Movie movie);

  Future<bool> isMovieInFavorites(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
