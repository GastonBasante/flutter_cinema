import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/helpers/date_parser.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';

class PersonMapper {
  static ActorDetails actorDetailsToEntity(
    PersonResponse actor,
  ) => ActorDetails(
    id: actor.id,
    biography: actor.biography ?? 'No encontramos informacion',
    birthday: SafeParser.date(actor.birthday),
    deathday: SafeParser.date(actor.deathday),
    gender: SafeParser.mapGender(actor.gender),
    homepage: actor,
    knownForDepartment: actor.knownForDepartment ?? 'Desconocido',
    name: actor.name,
    placeOfBirth: actor.placeOfBirth ?? 'Desconocido',
    popularity: actor.popularity,
    profilePath: actor.profilePath != null
        ? '${Environment.theMovieDbImage}${actor.profilePath}'
        : 'https://i.pinimg.com/736x/2c/47/d5/2c47d5dd5b532f83bb55c4cd6f5bd1ef.jpg',
  );

  static SocialMedia socialMediaToEntity(SocialMediaActor socialMedia) =>
      SocialMedia(
        imdbId: socialMedia.imdbId ?? '',
        facebookId: socialMedia.facebookId ?? '',
        instagramId: socialMedia.instagramId ?? '',
        tiktokId: socialMedia.tiktokId ?? '',
        twitterId: socialMedia.twitterId ?? '',
        youtubeId: socialMedia.youtubeId ?? '',
      );

  static MovieAndSerie movieAndSeries(
    CastMoviesAndSeries media,
  ) => MovieAndSerie(
    title: media.name ?? media.title,
    department: media.department ?? 'No info',
    episodeCount: media.episodeCount,
    character: media.character ?? '',
    job: media.job,
    mediaType: media.mediaType,
    id: media.id,
    backdropPath: media.backdropPath != null
        ? '${Environment.theMovieDbImage}${media.backdropPath}'
        : 'https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
    overview: media.overview,
    releaseDate: SafeParser.date(
      (media.firstCreditAirDate?.trim().isEmpty ?? true)
          ? media.releaseDate
          : media.firstCreditAirDate,
    ),
  );
}
