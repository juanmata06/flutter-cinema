import 'package:flutter_cinema/infrastructure/datasources/actors_datasource.dart';
import 'package:flutter_cinema/infrastructure/rempostory/actor_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Este repositorio es inmutable
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImplementation( ActorMovieDbDatasource() );
});
