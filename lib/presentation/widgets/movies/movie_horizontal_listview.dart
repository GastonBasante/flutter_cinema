import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Map<String, double>? config;
  final String? subTitle;

  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
    this.config = const {
      'width': 180.0,
      'height': 250.0,
      'margin-container': 8.00,
    },
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: Column(
        children: [
          _Title(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return FadeInRight(
                  child: _CardMovieView(movie: movie, config: widget.config),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CardMovieView extends StatelessWidget {
  final Movie movie;
  final config;
  const _CardMovieView({required this.movie, required this.config});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: config['margin-container']),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*image
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.network(
                width: config['width'],
                height: config['height'],
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),
          //*title
          SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2, style: textStyles.titleSmall),
          ),
          //*Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                //*icon
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                SizedBox(height: 3),
                //*votos
                Text(
                  HumanFormats.number(movie.voteAverage),
                  style: textStyles.bodyMedium?.copyWith(
                    color: Colors.yellow.shade800,
                  ),
                ),
                //*popularity
                Spacer(),
                Text(
                  HumanFormats.number(movie.popularity),
                  style: textStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Container(
        padding: EdgeInsets.only(top: 10),
        margin: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Row(
          children: [
            if (title != null) Text(title!, style: textStyle),
            const Spacer(),
            if (subTitle != null)
              FilledButton.tonal(
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!),
              ),
          ],
        ),
      ),
    );
  }
}
