import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref
          .watch(movieRepositoryProvider)
          .getPopularMovie;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final similarMoviesProvider =
    StateNotifierProvider<SimilarMoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref
          .watch(movieRepositoryProvider)
          .getMovieSimilar;
      return SimilarMoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

typedef MovieCallback = Future<List<Movie>> Function({int page});

typedef MovieSimilarCallback =
    Future<List<Movie>> Function({required String movieId, int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool isloading = false;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isloading) return;
    isloading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    await Future.delayed(Duration(milliseconds: 300));
    state = [...state, ...movies];
    isloading = false;
  }
}

class SimilarMoviesNotifier extends StateNotifier<List<Movie>> {
  final MovieSimilarCallback fetchMoreMovies;
  int currentPage = 0;
  bool isLoading = false;

  SimilarMoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPageById(String movieId) async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final movies = await fetchMoreMovies(movieId: movieId, page: currentPage);

    state = [...state, ...movies];

    isLoading = false;
  }
}
