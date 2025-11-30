import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(getActorsProvider.notifier).loadActor(widget.movieId);
    ref.read(watchProviderProvider.notifier).loadProviders(widget.movieId);
    ref.read(similarMoviesProvider.notifier).loadNextPageById(widget.movieId);
    ref.read(movieReviewProvider.notifier).loadAuthors(widget.movieId);
    ref.read(releaseDatesProvider.notifier).loadRelease(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movieInfo = ref.watch(movieInfoProvider)[widget.movieId];

    if (movieInfo == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movieInfo),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => _MovieDetails(movie: movieInfo),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends ConsumerWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieId = movie.id.toString();
    final int totalReview = ref.watch(totalAuthorsProvider);
    final List<Movie>? similarMovie = ref.watch(similarMoviesProvider);
    final ReleaseDates? releaseDates = ref.watch(releaseDatesProvider)[movieId];

    final List<ProviderMovie>? movieProviders = ref.watch(
      watchProviderProvider,
    )[movieId];

    final List<Author>? movieReview = ref.watch(movieReviewProvider)[movieId];

    if (similarMovie == null ||
        movieReview == null ||
        movieProviders == null ||
        releaseDates == null) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          movie.posterPath,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress != null) {
                              return Container(color: Colors.grey.shade900);
                            }
                            return child;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(movieProviders.isEmpty ? '' : 'Donde ver'),
                    SizedBox(
                      width: size.width * 0.3,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          ...movieProviders.map(
                            (providers) => _ViewProviders(provider: providers),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10),

                SizedBox(
                  width: (size.width - 40) * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: textStyle.titleLarge),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          releaseDates.certification == null ||
                                  releaseDates.certification == ''
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      color: Color.fromRGBO(220, 220, 220, 1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(releaseDates.certification!),
                                  ),
                                ),
                          Text(
                            movie.releaseDate == null
                                ? ''
                                : HumanFormats.dateDDMMYYYY(movie.releaseDate!),
                          ),
                          SizedBox(width: 10),
                          Text(HumanFormats.formatRuntime(movie.runtime)),
                        ],
                      ),

                      Text(movie.overview),
                      SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(4),
                          child: Wrap(
                            children: [
                              ...movie.genreIds.map(
                                (gender) => Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Chip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(15),
                                    ),
                                    label: Text(gender),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //genero de las pelicula
          // SizedBox(height: 5),
          _Title(title: 'Actores Principales'),
          _ActorsByMovie(movieId: movie.id),
          _Title(title: 'Reseñas ($totalReview)'),
          totalReview == 0
              ? SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('No tenemos reseñas de ${movie.title}.'),
                    ),
                  ),
                )
              : _ReviewByMovie(reviews: movieReview),

          similarMovie.isEmpty
              ? SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      _Title(title: 'Similares'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No tenemos suficiente información para recomendarte películas basadas en ${movie.title}.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : MovieHorizontalListview(
                  movies: similarMovie,
                  title: 'Similares',
                  config: {
                    'width': 135.00,
                    'height': 180.00,
                    'margin-container': 0.00,
                  },
                  loadNextPage: () => ref
                      .read(similarMoviesProvider.notifier)
                      .loadNextPageById(movie.id.toString()),
                ),
        ],
      ),
    );
  }
}

class _ReviewByMovie extends StatelessWidget {
  final List<Author> reviews;
  const _ReviewByMovie({required this.reviews});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50, child: Divider()),
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromRGBO(220, 220, 220, 1),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return SizedBox(
                      width: constraints.maxWidth, // 100% del contenedor
                      child: _ViewReviwers(review: review),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 50, child: Divider()),
        ],
      ),
    );
  }
}

class _ViewReviwers extends StatelessWidget {
  final Author review;
  const _ViewReviwers({required this.review});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Color.fromRGBO(220, 220, 220, 1), width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    review.authorDetails.avatarPath,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return SizedBox();
                      }

                      return FadeIn(child: child);
                    },
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Una reseña de ${review.author}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textStyle.bodyLarge!.fontSize,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            const TextSpan(text: 'Escrito por '),
                            TextSpan(
                              text: review.author,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' el ${HumanFormats.dateDDEMMMMYYYY(review.createdAt)}',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Text(review.content),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewProviders extends StatelessWidget {
  final ProviderMovie provider;
  const _ViewProviders({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(5),
        child: Image.network(
          width: 30,
          height: 30,
          provider.logoPath,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return SizedBox();
            }
            return FadeIn(child: child);
          },
        ),
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final int movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Actor>? actorsByMovie = ref.watch(
      getActorsProvider,
    )[movieId.toString()];

    if (actorsByMovie == null) {
      return Center(child: CircularProgressIndicator(strokeAlign: 2));
    }

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: actorsByMovie.length,
              itemBuilder: (context, index) {
                final actor = actorsByMovie[index];
                return FadeInRight(child: _ViewActors(actor: actor));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewActors extends StatelessWidget {
  final Actor actor;
  const _ViewActors({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*image
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.network(
                width: 135,
                height: 180,
                actor.profilePath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return SizedBox(width: 135, height: 180);
                  }
                  return GestureDetector(
                    onTap: () => context.push('/person/${actor.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 5),

          Text(actor.name, maxLines: 2),
          Text(
            actor.character ?? '',
            maxLines: 2,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.height * 0.7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
        // title: Text(
        //   movie.title,
        //   style: TextStyle(fontSize: 20, color: Colors.white),
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   stops: [0.7, 1.0],
                  //   colors: [Colors.transparent, Colors.black87],
                  // ),
                ),
              ),
            ),
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: Text(
          title,
          maxLines: 2,
          style: textStyle.titleLarge,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
