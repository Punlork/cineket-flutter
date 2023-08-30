part of 'now_showing_bloc.dart';

@immutable
sealed class NowShowingState extends Equatable {}

final class NowShowingInitial extends NowShowingState {
  @override
  List<Object?> get props => [];
}

final class NowShowingLoading extends NowShowingState {
  @override
  List<Object?> get props => [];
}

final class NowShowingLoaded extends NowShowingState {
  NowShowingLoaded({required this.result});

  final NowShowingRes result;

  NowShowingLoaded copyWith(NowShowingRes? result) {
    return NowShowingLoaded(result: result ?? this.result);
  }

  @override
  List<Object?> get props => [result];
}

final class NowShowingFailed extends NowShowingState {
  @override
  List<Object?> get props => [];
}
