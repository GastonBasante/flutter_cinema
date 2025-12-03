import 'package:cinemapedia/domain/entities/reviewer.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final movieReviewProvider =
    StateNotifierProvider<ReviewMoviesNotifier, Map<String, Reviewer>>((ref) {
      final getListReviews = ref
          .watch(movieRepositoryProvider)
          .getListReviewsByMovie;
      return ReviewMoviesNotifier(ref, getListReview: getListReviews);
    });

typedef ReviewMovieCallback =
    Future<Reviewer> Function({required String movieId, int page});

class ReviewMoviesNotifier extends StateNotifier<Map<String, Reviewer>> {
  final Ref ref;
  final ReviewMovieCallback getListReview;
  int currentPage = 0;
  bool isLoading = false;

  ReviewMoviesNotifier(this.ref, {required this.getListReview}) : super({});

  Future<void> loadAuthors(String movieId) async {
    if (isLoading) return;
    if (state[movieId] != null) return;
    isLoading = true;
    currentPage++;
    final response = await getListReview(movieId: movieId, page: 1);

    state = {...state, movieId: response};

    isLoading = false;
  }
}
