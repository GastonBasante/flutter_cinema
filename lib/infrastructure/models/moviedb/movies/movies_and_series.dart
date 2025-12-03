class MovieAndSerieResponse {
  final List<CastMoviesAndSeries> cast;
  final List<CastMoviesAndSeries> crew;
  final int id;

  MovieAndSerieResponse({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory MovieAndSerieResponse.fromJson(Map<String, dynamic> json) =>
      MovieAndSerieResponse(
        cast: List<CastMoviesAndSeries>.from(
          json["cast"].map((x) => CastMoviesAndSeries.fromJson(x)),
        ),
        crew: List<CastMoviesAndSeries>.from(
          json["crew"].map((x) => CastMoviesAndSeries.fromJson(x)),
        ),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    "id": id,
  };
}

class CastMoviesAndSeries {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String? originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double voteAverage;
  final int voteCount;
  final String? character;
  final String creditId;
  final int? order;
  final String mediaType;
  final List<String>? originCountry;
  final String? originalName;
  final String? firstAirDate;
  final String? name;
  final int? episodeCount;
  final String? firstCreditAirDate;
  final String? department;
  final String? job;

  CastMoviesAndSeries({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.character,
    required this.creditId,
    this.order,
    required this.mediaType,
    this.originCountry,
    this.originalName,
    this.firstAirDate,
    this.name,
    this.episodeCount,
    this.firstCreditAirDate,
    this.department,
    this.job,
  });

  factory CastMoviesAndSeries.fromJson(Map<String, dynamic> json) =>
      CastMoviesAndSeries(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? 'no-poster',
        releaseDate: json["release_date"] ?? '',
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        mediaType: json["media_type"],
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalName: json["original_name"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        episodeCount: json["episode_count"],
        firstCreditAirDate: json["first_credit_air_date"] ?? '',

        department: json["department"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "media_type": mediaType,
    "origin_country": originCountry == null
        ? []
        : List<dynamic>.from(originCountry!.map((x) => x)),
    "original_name": originalName,
    "first_air_date": firstAirDate,
    "name": name,
    "episode_count": episodeCount,
    "first_credit_air_date": firstCreditAirDate,
    "department": department,
    "job": job,
  };
}
