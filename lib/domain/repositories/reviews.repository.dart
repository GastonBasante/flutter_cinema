import 'package:cinemapedia/domain/entities/entities.dart';

abstract class ReviewsRepository {
  Future<List<Reviewer>> getReviewsByID({String reviewID});
}
