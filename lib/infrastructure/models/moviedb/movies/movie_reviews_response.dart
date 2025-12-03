import 'package:cinemapedia/infrastructure/models/moviedb/person/author_response.dart';

class MovieReviewsResponse {
  final int id;
  final int page;
  final List<Author> results;
  final int totalPages;
  final int totalResults;

  MovieReviewsResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieReviewsResponse.fromJson(Map<String, dynamic> json) =>
      MovieReviewsResponse(
        id: json["id"],
        page: json["page"],
        results: List<Author>.from(
          json["results"].map((x) => Author.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}
