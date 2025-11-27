import 'package:cinemapedia/config/constants/environment.dart';

class Author {
  final String id;
  final String author;
  final AuthorDetails authorDetails;
  final String content;
  final DateTime createdAt;

  Author({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    author: json["author"],
    authorDetails: AuthorDetails.fromJson(json["author_details"]),
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "author_details": authorDetails.toJson(),
    "content": content,
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}

class AuthorDetails {
  final String name;
  final String username;
  final String avatarPath;
  final double rating;

  AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
    name: json["name"],
    username: json["username"],
    avatarPath: json["avatar_path"] != null
        ? '${Environment.theMovieDbImage}${json["avatar_path"]}'
        : 'https://i.pinimg.com/736x/2c/47/d5/2c47d5dd5b532f83bb55c4cd6f5bd1ef.jpg',
    rating: json["rating"] ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "avatar_path": avatarPath,
    "rating": rating,
  };
}
