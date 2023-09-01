// To parse this JSON data, do
//
//     final nowShowingRes = nowShowingResFromJson(jsonString);

// ignore_for_file: avoid_dynamic_calls, lines_longer_than_80_chars, join_return_with_assignment

import 'dart:convert';

NowShowingRes nowShowingResFromJson(String str) =>
    NowShowingRes.fromJson(json.decode(str));

class NowShowingRes {
  NowShowingRes({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowShowingRes.fromJson(Map<String, dynamic> json) => NowShowingRes(
        dates: json['dates'] == null ? null : Dates.fromJson(json['dates']),
        page: json['page'],
        results:
            List<Result>.from(json['results'].map((e) => Result.fromJson(e))),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );

  final Dates? dates;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json['maximum']),
        minimum: DateTime.parse(json['minimum']),
      );
  final DateTime maximum;
  final DateTime minimum;
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity']?.toDouble(),
        posterPath: json['poster_path'],
        releaseDate: DateTime.parse(json['release_date']),
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
}
