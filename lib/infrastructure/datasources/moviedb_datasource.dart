import 'package:dio/dio.dart';

import 'package:flutter_cinema/config/constants/enviroments.dart';
import 'package:flutter_cinema/domain/datasources/movies_datasource.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/infrastructure/mappers/movie_mapper.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/movie_details_moviedb.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/moviedb_response.dart';

class MoviesDbDatasource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.movieDbBaseUrl,
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': Enviroment.movieDbApiLanguage
      }
    )
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.movieDbToEntity(movie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      'movie/now_playing', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      'movie/upcoming', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      'movie/popular', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      'movie/top_rated', 
      queryParameters: {
        'page': page
      }
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('movie/$id');
    if(response.statusCode != 200) throw Exception('$id Movie not found');
    
    final movieDbResponse = MovieDetailsMovieDB.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsMovieDbToEntity(movieDbResponse);
    return movie;
  }
}
