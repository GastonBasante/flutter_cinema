class ActorDetails {
  final int id;
  final String? biography;
  final DateTime? birthday;
  final DateTime? deathday;
  final String gender;
  final dynamic homepage;
  final String? knownForDepartment;
  final String name;
  final String? placeOfBirth;
  final double popularity;
  final String profilePath;

  ActorDetails({
    required this.id,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });
}
