// To parse this JSON data, do
//
//     final actorsResponse = actorsResponseFromMap(jsonString);

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter, constant_identifier_names, join_return_with_assignment

import 'dart:convert';

ActorsResponse actorsResponseFromMap(String str) =>
    ActorsResponse.fromMap(json.decode(str));

class ActorsResponse {
  ActorsResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ActorsResponse.fromMap(Map<String, dynamic> json) => ActorsResponse(
        page: json['page'],
        results: List<ActorResult>.from(
            json['results'].map((x) => ActorResult.fromMap(x))),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
  final int page;
  final List<ActorResult> results;
  final int totalPages;
  final int totalResults;
}

class ActorResult {
  ActorResult({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });

  factory ActorResult.fromMap(Map<String, dynamic> json) => ActorResult(
        adult: json['adult'],
        gender: json['gender'],
        id: json['id'],
        knownFor: List<KnownFor>.from(
          json['known_for'].map((x) => KnownFor.fromMap(x)),
        ),
        knownForDepartment: json['known_for_department'],
        name: json['name'],
        popularity: json['popularity']?.toDouble(),
        profilePath: json['profile_path'],
      );
  final bool adult;
  final int gender;
  final int id;
  final List<KnownFor> knownFor;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String profilePath;
}

class KnownFor {
  KnownFor({
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    this.adult,
    this.backdropPath,
    this.originalTitle,
    this.releaseDate,
    this.title,
    this.video,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalName,
  });

  factory KnownFor.fromMap(Map<String, dynamic> json) => KnownFor(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        mediaType: mediaTypeValues.map[json['media_type']]!,
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'] == null
            ? null
            : DateTime.parse(json['release_date']),
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average']?.toDouble(),
        voteCount: json['vote_count'],
        firstAirDate: json['first_air_date'] == null
            ? null
            : DateTime.parse(json['first_air_date']),
        name: json['name'],
        originCountry: json['origin_country'] == null
            ? []
            : List<String>.from(json['origin_country']!.map((x) => x)),
        originalName: json['original_name'],
      );
  final bool? adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final MediaType mediaType;
  final String originalLanguage;
  final String? originalTitle;
  final String overview;
  final String posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double voteAverage;
  final int voteCount;
  final DateTime? firstAirDate;
  final String? name;
  final List<String>? originCountry;
  final String? originalName;
}

enum MediaType { MOVIE, TV }

final mediaTypeValues =
    EnumValues({'movie': MediaType.MOVIE, 'tv': MediaType.TV});

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
