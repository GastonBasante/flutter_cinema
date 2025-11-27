import 'package:cinemapedia/domain/entities/provider_movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/legacy.dart';

final watchProviderProvider =
    StateNotifierProvider<
      WatchProviderNotifier,
      Map<String, List<ProviderMovie>>
    >((ref) {
      final getProvidersMovie = ref
          .watch(movieRepositoryProvider)
          .getWatchProviders;
      return WatchProviderNotifier(getWatchProvider: getProvidersMovie);
    });

typedef GetProviderCallback =
    Future<List<ProviderMovie>> Function(String movieId);

class WatchProviderNotifier
    extends StateNotifier<Map<String, List<ProviderMovie>>> {
  GetProviderCallback getWatchProvider;
  WatchProviderNotifier({required this.getWatchProvider}) : super({});

  Future<void> loadProviders(String movieId) async {
    if (state[movieId] != null) return;

    final providers = await getWatchProvider(movieId);
    state = {...state, movieId: providers};
  }
}
