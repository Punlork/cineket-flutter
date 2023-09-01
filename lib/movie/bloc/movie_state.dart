part of 'movie_bloc.dart';

@immutable
sealed class MovieState extends Equatable {}

final class MovieInitial extends MovieState {
  @override
  List<Object?> get props => [];
}

final class MovieLoading extends MovieState {
  @override
  List<Object?> get props => [];
}

final class MovieLoaded extends MovieState {
  MovieLoaded({required this.result});

  final NowShowingRes result;

  MovieLoaded copyWith(NowShowingRes? result) {
    return MovieLoaded(result: result ?? this.result);
  }

  @override
  List<Object?> get props => [result];
}

final class MovieFailed extends MovieState {
  @override
  List<Object?> get props => [];
}
