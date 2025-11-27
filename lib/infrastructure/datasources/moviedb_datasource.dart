import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.theMovieDbUrl,
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movie = movieDbResponse.results
        .where((e) => e.posterPath != 'no-poster')
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();
    return movie;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovie({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $movieId no found');
    }
    final movieDetail = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailToEntity(movieDetail);
    return movie;
  }

  @override
  Future<List<ProviderMovie>> getWatchProviders(String movieId) async {
    final response = await dio.get('/movie/$movieId/watch/providers');
    if (response.statusCode != 200) {
      throw Exception('Movie Provider with id: $movieId no found');
    }
    final providerResponse = MovieProvidersResponse.fromJson(response.data);

    //TODO: geolocalizacion para proveedor
    final flatrateAR = providerResponse.results['AR']?.flatrate ?? [];

    final List<ProviderMovie> provider = flatrateAR
        .map((providers) => MovieMapper.providerWatchToEntity(providers))
        .toList();
    return provider;
  }

  @override
  Future<List<Movie>> getMovieSimilar({
    required String movieId,
    int page = 1,
  }) async {
    final response = await dio.get(
      '/movie/$movieId/similar',
      queryParameters: {'page': page},
    );
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $movieId no found');
    }
    return _jsonToMovies(response.data);
  }

  @override
  Future<Reviewer> getListReviewsByMovie({
    required String movieId,
    int page = 1,
  }) async {
    final response = await dio.get(
      '/movie/$movieId/reviews',
      queryParameters: {'page': page},
    );
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $movieId no found');
    }
    final MovieReviewsResponse reviewResponse = MovieReviewsResponse.fromJson(
      response.data,
    );
    final reviews = MovieMapper.reviewerMovieToEntity(reviewResponse);

    return reviews;
  }
}
