// To parse this JSON data, do
//
//     final tvShowRes = tvShowResFromJson(jsonString);

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls, unnecessary_lambdas

import 'dart:convert';

TvShowRes tvShowResFromJson(String str) => TvShowRes.fromJson(json.decode(str));

class TvShowRes {
  TvShowRes({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  factory TvShowRes.fromJson(Map<String, dynamic> json) => TvShowRes(
        page: json['page'],
        results: List<TvShowResult>.from(
          json['results'].map(
            (e) => TvShowResult.fromJson(e),
          ),
        ),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
  final int page;
  final List<TvShowResult> results;
  final int totalPages;
  final int totalResults;
}

class TvShowResult {
  TvShowResult({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowResult.fromJson(Map<String, dynamic> json) => TvShowResult(
        backdropPath: json['backdrop_path'],
        firstAirDate: json['first_air_date'] != ''
            ? DateTime.parse(json['first_air_date'])
            : null,
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        name: json['name'],
        originCountry: List<String>.from(json['origin_country'].map((x) => x)),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity']?.toDouble(),
        posterPath: json['poster_path'],
        voteAverage: json['vote_average']?.toDouble(),
        voteCount: json['vote_count'],
      );

  final String backdropPath;
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
}
