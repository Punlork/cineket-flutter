part of 'actors_bloc.dart';

sealed class ActorsEvent extends Equatable {
  const ActorsEvent();

  @override
  List<Object> get props => [];
}

class OnActorRequest extends ActorsEvent {}
