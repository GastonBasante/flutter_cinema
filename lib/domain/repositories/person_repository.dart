import 'package:cinemapedia/domain/entities/entities.dart';

abstract class PersonRepository {
  Future<ActorDetails> getActorsDetails(String actorId);

  Future<List<MovieAndSerie>> getMoviesAndSeriesByActor(String actorId);

  Future<List<Movie>> getMoviesByActor(String actorId);

  Future<SocialMedia> getSocialmediaByActor(String actorId);
}
