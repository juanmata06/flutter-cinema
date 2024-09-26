import 'package:flutter_cinema/domain/entities/actor.dart';

abstract class ActorsDataSource {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
