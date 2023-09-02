// ignore_for_file: constant_identifier_names

abstract class ApiPath {
  static const String MOVIE_NOW_PLAY = 'movie/now_playing';
  static const String MOVIE_POPULAR = 'movie/popular';
  static const String MOVIE_TOP_RATED = 'movie/top_rated';
  static const String MOVIE_UPCOMING = 'movie/upcoming';

  static const String TV_AIR_TODAY = 'tv/airing_today';
  static const String TV_ON_AIR = 'tv/on_the_air';
  static const String TV_POPULAR = 'tv/popular';
  static const String TV_TOP_RATED = 'tv/top_rated';

  static const String ACTOR_POPULAR = 'person/popular';
}

abstract class SvgPath {
  static const String TMDB_LOGO = 'assets/svg/tmdb_logo.svg';
  static const String TMDB_LOGO_Alt = 'assets/svg/tmdb_logo_1.svg';
}
