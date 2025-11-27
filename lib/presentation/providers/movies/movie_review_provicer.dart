import 'package:cinemapedia/domain/entities/reviewer.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final totalAuthorsProvider = StateProvider<int>((_) => 0);

final movieReviewProvider =
    StateNotifierProvider<ReviewMoviesNotifier, Map<String, List<Author>>>((
      ref,
    ) {
      final getListReviews = ref
          .watch(movieRepositoryProvider)
          .getListReviewsByMovie;
      return ReviewMoviesNotifier(ref, getListReview: getListReviews);
    });

typedef ReviewMovieCallback =
    Future<Reviewer> Function({required String movieId, int page});

class ReviewMoviesNotifier extends StateNotifier<Map<String, List<Author>>> {
  final Ref ref;
  final ReviewMovieCallback getListReview;
  int currentPage = 0;
  bool isLoading = false;

  ReviewMoviesNotifier(this.ref, {required this.getListReview}) : super({});

  Future<void> loadAuthors(String movieId) async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final response = await getListReview(movieId: movieId, page: 1);
    final authors = response.author;
    final total = response.totalResults;

    ref.read(totalAuthorsProvider.notifier).state = total;

    state = {...state, movieId: authors};

    isLoading = false;
  }
}
