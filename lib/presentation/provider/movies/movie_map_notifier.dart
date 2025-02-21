import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/presentation/provider/providers_exports.dart';

final movieDetailsProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovieCallBack: movieRepository.getMovieById);
});

typedef GetMovieCallBack = Future<Movie> Function(String id);

//* This notifier searches for the movie in the cache, and if it doesn't find it, it makes a request to retrieve their details.
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovieCallBack;

  MovieMapNotifier({required this.getMovieCallBack}) : super({});

  Future<void> loadMovie(String id) async {
    if (state[id] != null) return;

    final movieIdForLookFor = await getMovieCallBack(id);

    state = {...state, id: movieIdForLookFor};
  }
}

