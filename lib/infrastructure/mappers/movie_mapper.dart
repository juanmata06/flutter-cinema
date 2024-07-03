import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/movie_details.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie apiMovieToEntityMovie(MovieMovieDB apiMovie) => Movie(
      adult: apiMovie.adult,
      backdropPath: (apiMovie.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${apiMovie.backdropPath}'
        : 'https://www.hotelsancarlosacapulco.com/image-not-available.png',
      genreIds: apiMovie.genreIds.map((e) => e.toString()).toList(),
      id: apiMovie.id,
      originalLanguage: apiMovie.originalLanguage,
      originalTitle: apiMovie.originalTitle,
      overview: apiMovie.overview,
      popularity: apiMovie.popularity,
      posterPath: (apiMovie.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${apiMovie.posterPath}'
        : 'no-poster',
      releaseDate: apiMovie.releaseDate,
      title: apiMovie.title,
      video: apiMovie.video,
      voteAverage: apiMovie.voteAverage,
      voteCount: apiMovie.voteCount
  );

    static Movie apiMovieDetailsToEntityMovie(MovieDetails apiMovie) => Movie(
      adult: apiMovie.adult,
      backdropPath: (apiMovie.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${apiMovie.backdropPath}'
        : 'https://www.hotelsancarlosacapulco.com/image-not-available.png',
      genreIds: apiMovie.genres.map((e) => e.name).toList(),
      id: apiMovie.id,
      originalLanguage: apiMovie.originalLanguage,
      originalTitle: apiMovie.originalTitle,
      overview: apiMovie.overview,
      popularity: apiMovie.popularity,
      posterPath: (apiMovie.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${apiMovie.posterPath}'
        : 'https://www.hotelsancarlosacapulco.com/image-not-available.png',
      releaseDate: apiMovie.releaseDate,
      title: apiMovie.title,
      video: apiMovie.video,
      voteAverage: apiMovie.voteAverage,
      voteCount: apiMovie.voteCount
  );
}
