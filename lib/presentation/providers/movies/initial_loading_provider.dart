import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(topRatedMoviesProvider).isEmpty;
  final step4 = ref.watch(upcomingMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;
  return false;
});

final initialLoadingMovieDetailProvider = Provider<bool>((ref) {
  final step1 = ref.watch(movieInfoProvider).isEmpty;
  final step2 = ref.watch(getActorsProvider).isEmpty;
  final step3 = ref.watch(watchProviderProvider).isEmpty;
  final step4 = ref.watch(similarMoviesProvider).isEmpty;
  final step5 = ref.watch(movieReviewProvider).isEmpty;

  if (step1 || step2 || step3 || step4 || step5) return true;
  return false;
});
