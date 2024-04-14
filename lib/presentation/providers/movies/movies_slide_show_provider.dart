import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/presentation/providers/providers_exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Con este provider lo que queremos es acortar la petición de getNowPlaying
/// sin necesidad de modificar la petición en si, sino su respuesta

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if(nowPlayingMovies.isEmpty) {
    return [];
  }
  
  return nowPlayingMovies.sublist(0, 6);
});
