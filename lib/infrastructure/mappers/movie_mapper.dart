import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/provider_movie.dart';
import 'package:cinemapedia/domain/entities/reviewer.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: moviedb.backdropPath.isNotEmpty
        ? '${Environment.theMovieDbImage}${moviedb.backdropPath}'
        : 'https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
    genreIds: moviedb.genreIds.map((element) => element.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.backdropPath,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: moviedb.posterPath.isNotEmpty
        ? '${Environment.theMovieDbImage}${moviedb.posterPath}'
        : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );

  static Movie movieDetailToEntity(MovieDetails movie) => Movie(
    adult: movie.adult,
    backdropPath: movie.backdropPath.isNotEmpty
        ? '${Environment.theMovieDbImage}${movie.backdropPath}'
        : 'https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
    genreIds: movie.genres.map((element) => element.name).toList(),
    id: movie.id,
    originalLanguage: movie.backdropPath,
    originalTitle: movie.originalTitle,
    overview: movie.overview,
    popularity: movie.popularity,
    posterPath: movie.posterPath.isNotEmpty
        ? '${Environment.theMovieDbImage}${movie.posterPath}'
        : 'https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
    releaseDate: movie.releaseDate,
    title: movie.title,
    video: movie.video,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount,
  );

  static ProviderMovie providerWatchToEntity(Flatrate provider) =>
      ProviderMovie(
        logoPath: provider.logoPath.isNotEmpty
            ? '${Environment.theMovieDbImage}${provider.logoPath}'
            : 'no logo',
        providerId: provider.providerId,
        providerName: provider.providerName,
      );

  static Reviewer reviewerMovieToEntity(MovieReviewsResponse reviewer) =>
      Reviewer(author: reviewer.results, totalResults: reviewer.totalResults);
}
