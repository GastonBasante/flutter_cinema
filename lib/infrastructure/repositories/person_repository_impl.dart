import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/domain/repositories/person_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/person_moviedb_datasource.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PersonMoviedbDatasource datasource;

  PersonRepositoryImpl({required this.datasource});

  @override
  Future<ActorDetails> getActorsDetails(String actorId) {
    return datasource.getActorsDetails(actorId);
  }

  @override
  Future<List<MovieAndSerie>> getMoviesAndSeriesByActor(String actorId) {
    return datasource.getMoviesAndSeriesByActor(actorId);
  }

  @override
  Future<List<Movie>> getMoviesByActor(String actorId) {
    return datasource.getMoviesByActor(actorId);
  }

  @override
  Future<SocialMedia> getSocialmediaByActor(String actorId) {
    return datasource.getSocialmediaByActor(actorId);
  }
}
