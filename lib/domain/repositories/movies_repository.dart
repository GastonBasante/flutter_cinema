import 'package:cinemapedia/domain/entities/entities.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopularMovie({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieId(String movieId);

  Future<List<Movie>> getMovieSimilar({required String movieId, int page = 1});

  Future<List<ProviderMovie>> getWatchProviders(String movieId);

  Future<Reviewer> getListReviewsByMovie({
    required String movieId,
    int page = 1,
  });
}
