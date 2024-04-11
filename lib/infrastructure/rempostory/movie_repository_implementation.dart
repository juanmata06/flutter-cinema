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
}
