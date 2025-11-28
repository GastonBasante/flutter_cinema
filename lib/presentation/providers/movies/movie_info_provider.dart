import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final fechMoreMovides = ref.watch(movieRepositoryProvider).getMovieId;
      return MovieMapNotifier(getMovie: fechMoreMovides);
    });

final releaseDatesProvider =
    StateNotifierProvider<ReleaseMapNotifier, Map<String, ReleaseDates>>((ref) {
      final getReleaseDates = ref
          .watch(movieRepositoryProvider)
          .getReleaseDatesByMovie;
      return ReleaseMapNotifier(getRelease: getReleaseDates);
    });

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}

typedef GetReleaseMovieCallback = Future<ReleaseDates> Function(String);

class ReleaseMapNotifier extends StateNotifier<Map<String, ReleaseDates>> {
  GetReleaseMovieCallback getRelease;
  ReleaseMapNotifier({required this.getRelease}) : super({});

  Future<void> loadRelease(String movieId) async {
    if (state[movieId] != null) return;

    final release = await getRelease(movieId);
    state = {...state, movieId: release};
  }
}
