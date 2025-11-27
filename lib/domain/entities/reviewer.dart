import 'package:cinemapedia/infrastructure/models/models.dart';

class Reviewer {
  final List<Author> author;
  final int totalResults;
  Reviewer({required this.author, required this.totalResults});
}
