
import 'package:flutter_cinema/domain/entities/actor.dart';
import 'package:flutter_cinema/domain/datasources/actors_datasource.dart';
import 'package:flutter_cinema/domain/repositories/actors_repository.dart';

class ActorRepositoryImplementation extends ActorsRepository {
  final ActorsDatasource datasource;
  ActorRepositoryImplementation(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovieId(String id) {
    return datasource.getActorsByMovieId(id);
  }
}