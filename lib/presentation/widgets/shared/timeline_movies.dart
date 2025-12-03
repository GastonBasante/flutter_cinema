import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineMovies extends StatelessWidget {
  final List<MovieAndSerie> movies;
  const TimelineMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final movie = movies[index];
        final bool isLeft = index % 2 == 0;

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.5, // Línea al centro

          indicatorStyle: IndicatorStyle(
            width: 30,
            color: Colors.orange,
            indicatorXY: 0.5,
          ),

          beforeLineStyle: LineStyle(
            color: Colors.orange.shade300,
            thickness: 3,
          ),
          afterLineStyle: LineStyle(
            color: Colors.orange.shade300,
            thickness: 3,
          ),

          // CONTENIDO A IZQUIERDA O DERECHA
          startChild: isLeft
              ? _LeftBlock(date: HumanFormats.dateDDMMYYYY(movie.releaseDate))
              : _MovieCard(movie: movie),

          endChild: isLeft
              ? _MovieCard(movie: movie)
              : _RightBlock(date: HumanFormats.dateDDMMYYYY(movie.releaseDate)),

          isFirst: index == 0,
          isLast: index == movies.length - 1,
        );
      },
    );
  }
}

class _LeftBlock extends StatelessWidget {
  final String date;

  const _LeftBlock({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.centerRight,
      child: Text(
        date,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class _RightBlock extends StatelessWidget {
  final String date;

  const _RightBlock({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.centerLeft,
      child: Text(
        date,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final MovieAndSerie movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            movie.title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //*image
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.network(
                width: 150,
                height: 200,
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
          Text(movie.mediaType, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(movie.character),
        ],
      ),
    );
  }
}
