part of 'tv_show_bloc.dart';

sealed class TvShowState extends Equatable {
  const TvShowState();

  @override
  List<Object> get props => [];
}

final class TvShowInitial extends TvShowState {}

final class TvShowLoading extends TvShowState {}

final class TvShowLoaded extends TvShowState {
  const TvShowLoaded({required this.result});

  final TvShowRes result;

  TvShowLoaded copyWith(TvShowRes? result) =>
      TvShowLoaded(result: result ?? this.result);
}

final class TvShowFailed extends TvShowState {}
