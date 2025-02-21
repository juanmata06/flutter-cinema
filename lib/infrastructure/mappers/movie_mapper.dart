import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/movie_moviedb.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/movie_details_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieDB) => Movie(
    adult: movieDB.adult,
    backdropPath: movieDB.backdropPath != '' ? 
      'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}' : 
      'https://media.licdn.com/dms/image/v2/D4D03AQHJGJTKjiBGeQ/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1703755861417?e=1744243200&v=beta&t=cWq-TsSYli3Uu-h6XeOjyOtLlT36wue4Oj4A-dduWyU',
    genreIds: movieDB.genreIds.map((genre) => genre.toString()).toList(),
    id: movieDB.id,
    originalLanguage: movieDB.originalLanguage,
    originalTitle: movieDB.originalTitle,
    overview: movieDB.overview,
    popularity: movieDB.popularity,
    posterPath: movieDB.posterPath != '' ? 
      'https://image.tmdb.org/t/p/w500${movieDB.posterPath}' : 
      'no-poster', 
    releaseDate: movieDB.releaseDate,
    title: movieDB.title,
    video: movieDB.video,
    voteAverage: movieDB.voteAverage,
    voteCount: movieDB.voteCount
  );

  static Movie movieDetailsMovieDbToEntity(MovieDetailsMovieDB apiMovie) => Movie(
    adult: apiMovie.adult,
    backdropPath: (apiMovie.backdropPath != '') ? 
      'https://image.tmdb.org/t/p/w500${apiMovie.backdropPath}' : 
      'https://www.hotelsancarlosacapulco.com/image-not-available.png',
    genreIds: apiMovie.genres.map((e) => e.name).toList(),
    id: apiMovie.id,
    originalLanguage: apiMovie.originalLanguage,
    originalTitle: apiMovie.originalTitle,
    overview: apiMovie.overview,
    popularity: apiMovie.popularity,
    posterPath: (apiMovie.posterPath != '') ? 
      'https://image.tmdb.org/t/p/w500${apiMovie.posterPath}' : 
      'https://www.hotelsancarlosacapulco.com/image-not-available.png',
    releaseDate: apiMovie.releaseDate,
    title: apiMovie.title,
    video: apiMovie.video,
    voteAverage: apiMovie.voteAverage,
    voteCount: apiMovie.voteCount
  );
}
