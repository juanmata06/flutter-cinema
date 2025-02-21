import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: movieDB.backdropPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      : 'https://media.licdn.com/dms/image/v2/D4D03AQHJGJTKjiBGeQ/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1703755861417?e=1744243200&v=beta&t=cWq-TsSYli3Uu-h6XeOjyOtLlT36wue4Oj4A-dduWyU',
      genreIds: movieDB.genreIds.map((genre) => genre.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: movieDB.posterPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      : 'no-poster',
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);
}
