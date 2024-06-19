import 'package:dio/dio.dart';

import 'package:flutter_cinema/config/constants/enviroment.dart';
import 'package:flutter_cinema/domain/datasources/movies_datasources.dart';

import 'package:flutter_cinema/infrastructure/mappers/movie_mapper.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.baseUrl, queryParameters: {
    'api_key': Enviroment.mdbKey,
    'language': Enviroment.apiLanguage
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing', 
      queryParameters: {'page': page}
    );

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
      .where((movieFromApi) => movieFromApi.posterPath != 'no-poster')
      .map((movieFromApi) => MovieMapper.apiMovieToEntityMovie(movieFromApi)
    ).toList();

    return movies;
  }
}
