import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../movies/movies_repository_provider.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final searchMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final moviesProvider = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
    callBack: moviesProvider.searchMovie, 
    ref: ref
  );
});

typedef SearchedMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesCallBack callBack;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.callBack, required this.ref
  }): super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await callBack(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
