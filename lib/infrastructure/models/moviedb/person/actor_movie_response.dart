import 'package:cinemapedia/infrastructure/models/models.dart';

class ActorMovieResponse {
  final List<MovieMovieDB> cast;
  final List<dynamic> crew;
  final int id;

  ActorMovieResponse({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory ActorMovieResponse.fromJson(Map<String, dynamic> json) =>
      ActorMovieResponse(
        cast: List<MovieMovieDB>.from(
          json["cast"].map((x) => MovieMovieDB.fromJson(x)),
        ),
        crew: List<dynamic>.from(json["crew"].map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x)),
    "id": id,
  };
}
