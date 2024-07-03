import 'package:flutter_cinema/domain/datasources/actors_datasources.dart';
import 'package:flutter_cinema/domain/entities/actor.dart';
import 'package:flutter_cinema/domain/repositories/actors_repositories.dart';

class ActorRepositoryImplementation extends ActorsRepository {
  final ActorsDataSource datasource;
  ActorRepositoryImplementation(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
