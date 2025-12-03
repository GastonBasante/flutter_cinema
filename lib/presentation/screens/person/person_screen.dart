import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/expandable_text.dart';
import 'package:cinemapedia/presentation/widgets/shared/info_field.dart';
import 'package:cinemapedia/presentation/widgets/shared/timeline_movies.dart';
import 'package:cinemapedia/presentation/widgets/shared/title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonScreen extends ConsumerStatefulWidget {
  static const name = 'person-screen';
  final String personId;
  const PersonScreen({super.key, required this.personId});

  @override
  PersonScreenState createState() => PersonScreenState();
}

class PersonScreenState extends ConsumerState<PersonScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(getActorsDetailsProvider.notifier).loadActor(widget.personId);
    ref.read(getMoviesActorProvider.notifier).loadMovie(widget.personId);
    ref
        .read(getMoviesAndSeriesActorProvider.notifier)
        .loadMovie(widget.personId);
    ref
        .read(getSocialMediaActorProvider.notifier)
        .loadSocialMedia(widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final ActorDetails? actorDetails = ref.watch(
      getActorsDetailsProvider,
    )[widget.personId];
    if (actorDetails == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          actorDetails.name.toString(),
          style: TextStyle(
            fontSize: textStyle.titleLarge!.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _PersonView(
        actorDetails: actorDetails,
        size: size,
        textStyle: textStyle,
      ),
    );
  }
}

class _PersonView extends ConsumerWidget {
  const _PersonView({
    required this.actorDetails,
    required this.size,
    required this.textStyle,
  });

  final ActorDetails actorDetails;
  final Size size;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personId = actorDetails.id.toString();
    final List<Movie>? movie = ref.watch(getMoviesActorProvider)[personId];
    final List<MovieAndSerie>? movieAndSerie = ref.watch(
      getMoviesAndSeriesActorProvider,
    )[personId];
    final SocialMedia? socialMedia = ref.watch(
      getSocialMediaActorProvider,
    )[personId];

    if (movie == null || movieAndSerie == null || socialMedia == null) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 1, (context, index) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // FOTO
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          actorDetails.profilePath,
                          width: size.width * 0.45,
                          height: 300,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress != null) {
                              return SizedBox();
                            }
                            return FadeIn(child: child);
                          },
                        ),
                      ),
                    ),

                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleField(title: 'Información Personal'),

                          SizedBox(height: 10),

                          InfoField(
                            label: 'Conocido/a por',
                            value: actorDetails.knownForDepartment!,
                          ),

                          actorDetails.birthday == null
                              ? SizedBox()
                              : InfoField(
                                  label: 'Cumpleaños',
                                  value:
                                      '${HumanFormats.dateDDEMMMMYYYY(actorDetails.birthday!)} (${HumanFormats.calculateAge(actorDetails.birthday!)} años)',
                                ),

                          actorDetails.deathday == null
                              ? SizedBox()
                              : InfoField(
                                  label: 'Fallecimiento',
                                  value: HumanFormats.dateDDEMMMMYYYY(
                                    actorDetails.deathday!,
                                  ),
                                ),

                          InfoField(
                            label: 'Popularidad',
                            value: actorDetails.popularity.toString(),
                          ),

                          InfoField(label: 'Sexo', value: actorDetails.gender),

                          InfoField(
                            label: 'Lugar de Nacimiento',
                            value: actorDetails.placeOfBirth!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //Informacion del actor
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      TitleField(title: 'Biografía'),
                      SizedBox(height: 10),
                      actorDetails.biography!.isEmpty
                          ? SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'No tenemos Biografia de ${actorDetails.name}.',
                                  ),
                                ),
                              ),
                            )
                          : ExpandableText(
                              alignment: AlignmentGeometry.centerRight,
                              text: actorDetails.biography!,
                              maxLines: 10,
                            ),

                      TitleField(title: 'Todos sus trabajos'),

                      TimelineMovies(movies: movieAndSerie),

                
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
