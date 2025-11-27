import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtonNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isloadingProvider = ref.watch(initialLoadingProvider);
    if (isloadingProvider) return FullScreenLoader();
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: Colors.white,
          flexibleSpace: CustomAppbar(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 1, (context, index) {
            return Column(
              children: [
                MoviesSlideshow(movie: moviesSlideshow),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Proximamente',
                  subTitle: 'En este mes',
                  loadNextPage: ref
                      .read(upcomingMoviesProvider.notifier)
                      .loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: ref
                      .read(popularMoviesProvider.notifier)
                      .loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  loadNextPage: ref
                      .read(topRatedMoviesProvider.notifier)
                      .loadNextPage,
                ),
                SizedBox(height: 10),
              ],
            );
          }),
        ),
      ],
    );
  }
}
