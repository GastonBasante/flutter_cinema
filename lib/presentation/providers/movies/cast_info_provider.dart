import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/legacy.dart';

final getActorsProvider =
    StateNotifierProvider<GetActorNotifier, Map<String, List<Actor>>>((ref) {
      final getActors = ref.watch(movieRepositoryProvider).getActorsByMovie;
      return GetActorNotifier(getActor: getActors);
    });

typedef GetActorCallback = Future<List<Actor>> Function(String movieId);

class GetActorNotifier extends StateNotifier<Map<String, List<Actor>>> {
  GetActorCallback getActor;
  GetActorNotifier({required this.getActor}) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActor(movieId);
    state = {...state, movieId: actors};
  }
}
