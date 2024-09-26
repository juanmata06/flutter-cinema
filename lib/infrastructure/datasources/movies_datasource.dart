import 'package:dio/dio.dart';

import 'package:flutter_cinema/config/constants/enviroment.dart';
import 'package:flutter_cinema/domain/datasources/movies_datasources.dart';

import 'package:flutter_cinema/infrastructure/mappers/movie_mapper.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/movie_details.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.baseUrl, queryParameters: {
    'api_key': Enviroment.mdbKey,
    'language': Enviroment.apiLanguage
  }));

  List<Movie> _jsonToMovies( Map<String,dynamic> json ) {

    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviedb) => MovieMapper.apiMovieToEntityMovie(moviedb)
    ).toList();

    return movies;

  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing', 
      queryParameters: {'page': page}
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular', 
      queryParameters: {'page': page}
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming', 
      queryParameters: {'page': page}
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated', 
      queryParameters: {'page': page}
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if(response.statusCode != 200) throw Exception('Error al obtener detalles de pelicula');
    return MovieMapper.apiMovieDetailsToEntityMovie(MovieDetails.fromJson(response.data));
  }
}
