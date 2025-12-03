import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/person/actors_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

typedef GetSocialMediaeCallback = Future<SocialMedia> Function(String movieId);
typedef GetActorDetailsCallback = Future<ActorDetails> Function(String actorId);
typedef GetPersonMovieCallback = Future<List<Movie>> Function(String movieId);

final getActorsDetailsProvider =
    StateNotifierProvider<GetActorDetailsNotifier, Map<String, ActorDetails>>((
      ref,
    ) {
      final getActors = ref.watch(actorRepositoryProvider).getActorsDetails;
      return GetActorDetailsNotifier(getActor: getActors);
    });

final getMoviesActorProvider =
    StateNotifierProvider<PersonMapNotifier<Movie>, Map<String, List<Movie>>>((
      ref,
    ) {
      final getMovies = ref.watch(actorRepositoryProvider).getMoviesByActor;

      return PersonMapNotifier<Movie>(
        getItems: getMovies,
        getReleaseDate: (m) => m.releaseDate,
      );
    });
final getMoviesAndSeriesActorProvider =
    StateNotifierProvider<
      PersonMapNotifier<MovieAndSerie>,
      Map<String, List<MovieAndSerie>>
    >((ref) {
      final getMoviesAndSeries = ref
          .watch(actorRepositoryProvider)
          .getMoviesAndSeriesByActor;

      return PersonMapNotifier<MovieAndSerie>(
        getItems: getMoviesAndSeries,
        getReleaseDate: (m) => m.releaseDate,
      );
    });

final getSocialMediaActorProvider =
    StateNotifierProvider<PersonSocialMediaNotifier, Map<String, SocialMedia>>((
      ref,
    ) {
      final getSocialMedia = ref
          .watch(actorRepositoryProvider)
          .getSocialmediaByActor;
      return PersonSocialMediaNotifier(getSocalMedia: getSocialMedia);
    });

class GetActorDetailsNotifier extends StateNotifier<Map<String, ActorDetails>> {
  GetActorDetailsCallback getActor;
  GetActorDetailsNotifier({required this.getActor}) : super({});

  Future<void> loadActor(String personId) async {
    if (state[personId] != null) return;
    final ActorDetails actorDetails = await getActor(personId);
    state = {...state, personId: actorDetails};
  }
}

typedef HasReleaseDateGetter<T> = DateTime? Function(T);

class PersonMapNotifier<T> extends StateNotifier<Map<String, List<T>>> {
  final Future<List<T>> Function(String personId) getItems;
  final HasReleaseDateGetter<T> getReleaseDate;
  PersonMapNotifier({required this.getItems, required this.getReleaseDate})
    : super({});

  Future<void> loadMovie(String personId) async {
    if (state[personId] != null) return;

    final List<T> items = await getItems(personId);

    // Ordenar por fecha más reciente primero
    items.sort((a, b) {
      final dateA = getReleaseDate(a);
      final dateB = getReleaseDate(b);

      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;

      return dateB.compareTo(dateA);
    });
    state = {...state, personId: items};
  }
}

class PersonSocialMediaNotifier
    extends StateNotifier<Map<String, SocialMedia>> {
  GetSocialMediaeCallback getSocalMedia;
  PersonSocialMediaNotifier({required this.getSocalMedia}) : super({});

  Future<void> loadSocialMedia(String personId) async {
    if (state[personId] != null) return;

    final SocialMedia socialMedia = await getSocalMedia(personId);
    state = {...state, personId: socialMedia};
  }
}
