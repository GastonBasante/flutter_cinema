import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/person_datasources.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infrastructure/mappers/person_mapper.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:dio/dio.dart';

class PersonMoviedbDatasource extends PersonDatasources {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.theMovieDbUrl,
      queryParameters: {'api_key': Environment.theMovieDbKey},
    ),
  );

  @override
  Future<ActorDetails> getActorsDetails(String actorId) async {
    final response = await dio.get('/person/$actorId');

    final PersonResponse personResponse = PersonResponse.fromJson(
      response.data,
    );
    final ActorDetails actor = PersonMapper.actorDetailsToEntity(
      personResponse,
    );
    return actor;
  }

  @override
  Future<List<MovieAndSerie>> getMoviesAndSeriesByActor(String actorId) async {
    final response = await dio.get('/person/$actorId/combined_credits');

    final movieResponse = MovieAndSerieResponse.fromJson(response.data);
    final List<MovieAndSerie> movieAndSerie = movieResponse.cast
        .where((e) => e.posterPath != 'no-poster')
        .map((e) => PersonMapper.movieAndSeries(e))
        .toList();
    return movieAndSerie;
  }

  @override
  Future<List<Movie>> getMoviesByActor(String actorId) async {
    final response = await dio.get('/person/$actorId/movie_credits');

    final movieResponse = ActorMovieResponse.fromJson(response.data);
    final List<Movie> movie = movieResponse.cast
        .where((e) => e.posterPath != 'no-poster')
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();
    return movie;
  }

  @override
  Future<SocialMedia> getSocialmediaByActor(String actorId) async {
    final json = await dio.get('/person/$actorId/external_ids');
    final SocialMediaActor socialMediaResponse = SocialMediaActor.fromJson(
      json.data,
    );
    final SocialMedia socialMedia = PersonMapper.socialMediaToEntity(
      socialMediaResponse,
    );
    return socialMedia;
  }
}
