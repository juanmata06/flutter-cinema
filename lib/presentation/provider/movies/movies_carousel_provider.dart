import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_cinema/domain/entities/movie.dart';
import 'movies_providers.dart';

final moviesCarouselProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0, 6);
});
