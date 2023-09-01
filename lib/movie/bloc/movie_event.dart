part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent {}

final class MovieRequested extends MovieEvent {
  MovieRequested({required this.path});

  final String path;
}
