import 'package:dio/dio.dart';

import 'package:flutter_cinema/config/constants/enviroments.dart';
import 'package:flutter_cinema/domain/entities/actor.dart';
import 'package:flutter_cinema/domain/datasources/actors_datasource.dart';
import 'package:flutter_cinema/infrastructure/mappers/actor_mapper.dart';
import 'package:flutter_cinema/infrastructure/models/moviedb/actors_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Enviroment.theMovieDbKey,
      'language': Enviroment.movieDbApiLanguage
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovieId(String id) async{
    final response = await dio.get(
      '/movie/$id/credits'
    );
    
    final castResponse = ActorsResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    return actors;
  }

}