part of 'tv_show_bloc.dart';

sealed class TvShowEvent extends Equatable {
  const TvShowEvent();

  @override
  List<Object> get props => [];
}

final class TvShowRequested extends TvShowEvent {
  const TvShowRequested({required this.path});

  final String path;
}
