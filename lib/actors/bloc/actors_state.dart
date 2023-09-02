part of 'actors_bloc.dart';

sealed class ActorsState extends Equatable {
  const ActorsState();

  @override
  List<Object> get props => [];
}

final class ActorsInitial extends ActorsState {}

final class ActorsLoading extends ActorsState {}

final class ActorsLoaded extends ActorsState {
  const ActorsLoaded({required this.result});

  final ActorsResponse result;

  ActorsLoaded copyWith(ActorsResponse? result) =>
      ActorsLoaded(result: result ?? this.result);

  @override
  List<Object> get props => [result];
}

final class ActorsFailed extends ActorsState {}
