import 'package:cinemapedia/domain/entities/entities.dart';

abstract class ActorsDatasources {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
