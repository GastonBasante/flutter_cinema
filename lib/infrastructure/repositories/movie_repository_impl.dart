import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/provider_movie.dart';
import 'package:cinemapedia/domain/entities/reviewer.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasources datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovie({int page = 1}) {
    return datasource.getPopularMovie(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieId(String movieId) {
    return datasource.getMovieId(movieId);
  }

  @override
  Future<List<ProviderMovie>> getWatchProviders(String movieId) {
    return datasource.getWatchProviders(movieId);
  }

  @override
  Future<List<Movie>> getMovieSimilar({required String movieId, int page = 1}) {
    return datasource.getMovieSimilar(movieId: movieId, page: page);
  }

  @override
  Future<Reviewer> getListReviewsByMovie({
    required String movieId,
    int page = 1,
  }) {
    return datasource.getListReviewsByMovie(movieId: movieId, page: page);
  }
}
