import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_cinema/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:flutter_cinema/infrastructure/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImplementation( ActorMovieDbDatasource() );
});