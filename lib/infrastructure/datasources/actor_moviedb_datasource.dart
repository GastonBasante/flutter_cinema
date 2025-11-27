import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasources.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasources {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.theMovieDbUrl,
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final CreditsResponse creditResponse = CreditsResponse.fromJson(
      response.data,
    );
    final List<Actor> actor = creditResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
    return actor;
  }
}
