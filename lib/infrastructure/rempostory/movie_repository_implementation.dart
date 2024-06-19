import 'package:flutter_cinema/domain/datasources/movies_datasources.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/domain/repositories/movies_repositories.dart';

class MovieRepositoryImplementation extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImplementation(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }
}
