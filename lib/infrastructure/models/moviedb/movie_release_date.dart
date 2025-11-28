class MovieReleaseDatesResponse {
  final int id;
  final List<Release> results;

  MovieReleaseDatesResponse({required this.id, required this.results});

  factory MovieReleaseDatesResponse.fromJson(Map<String, dynamic> json) =>
      MovieReleaseDatesResponse(
        id: json["id"],
        results: List<Release>.from(
          json["results"].map((x) => Release.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Release {
  final String iso31661;
  final List<ReleaseDate> releaseDates;

  Release({required this.iso31661, required this.releaseDates});

  factory Release.fromJson(Map<String, dynamic> json) => Release(
    iso31661: json["iso_3166_1"],
    releaseDates: List<ReleaseDate>.from(
      json["release_dates"].map((x) => ReleaseDate.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "iso_3166_1": iso31661,
    "release_dates": List<dynamic>.from(releaseDates.map((x) => x.toJson())),
  };
}

class ReleaseDate {
  final String certification;
  final List<String> descriptors;
  final String iso6391;
  final String note;
  final DateTime releaseDate;
  final int type;

  ReleaseDate({
    required this.certification,
    required this.descriptors,
    required this.iso6391,
    required this.note,
    required this.releaseDate,
    required this.type,
  });

  factory ReleaseDate.fromJson(Map<String, dynamic> json) => ReleaseDate(
    certification: json["certification"],
    descriptors: List<String>.from(json["descriptors"].map((x) => x)),
    iso6391: json["iso_639_1"],
    note: json["note"],
    releaseDate: DateTime.parse(json["release_date"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "certification": certification,
    "descriptors": List<dynamic>.from(descriptors.map((x) => x)),
    "iso_639_1": iso6391,
    "note": note,
    "release_date": releaseDate.toIso8601String(),
    "type": type,
  };
}
