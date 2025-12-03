class MovieAndSerie {
  final int id;
  final String backdropPath;
  final String department;
  final String overview;
  final int? episodeCount;
  final String? job;
  final String character;
  final DateTime? releaseDate;
  final String? title;
  final String mediaType;

  MovieAndSerie({
    required this.character,
    required this.department,
    required this.episodeCount,
    required this.job,
    required this.mediaType,
    required this.id,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.title,
  });
}
