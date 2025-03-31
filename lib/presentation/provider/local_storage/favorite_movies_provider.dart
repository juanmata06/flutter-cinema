import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/domain/repositories/local_storage_repositorie.dart';
import 'package:flutter_cinema/presentation/provider/providers_exports.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier,Map<int, Movie>>((ref){
  final repository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(storageRepositorie: repository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepositorie storageRepositorie;

  StorageMoviesNotifier({required this.storageRepositorie}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await storageRepositorie.loadMovies(offset: page * 10, limit: 20);
    page++;

    final newMovies = <int, Movie>{};
    for (final movie in movies) {
      newMovies[movie.id] = movie;
    }
    state = {...state, ...newMovies};
    
    return movies;
  }

  Future<void> toogleFavorite(Movie movie) async {
    await storageRepositorie.toggleAsFavorite(movie);
    final bool isFavoriteMovie = state[movie.id] != null;

    if(isFavoriteMovie){
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
