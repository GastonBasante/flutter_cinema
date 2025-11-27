import 'package:cinemapedia/domain/entities/entities.dart';

abstract class ReviewsDatasources {
  Future<Reviewer> getReviewsByID({String reviewID});
}
