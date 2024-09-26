import 'package:dio/dio.dart';
import 'package:flutter_cinema/config/constants/enviroment.dart';
import 'package:flutter_cinema/domain/datasources/actors_datasources.dart';
import 'package:flutter_cinema/domain/entities/actor.dart';
import 'package:flutter_cinema/infrastructure/mappers/actor_mapper.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/actors_response.dart';

class ActorMovieDbDatasource extends ActorsDataSource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Enviroment.mdbKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    print('lanzando ${movieId}');
    final response = await dio.get(
      '/movie/$movieId/credits'
    );

    final castResponse = ActorsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    
    return actors;
  }

}