import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cineket/actors/model/response.dart';
import 'package:cineket/actors/service/actor_service.dart';
import 'package:equatable/equatable.dart';

part 'actors_event.dart';
part 'actors_state.dart';

class ActorsBloc extends Bloc<ActorsEvent, ActorsState> {
  ActorsBloc() : super(ActorsInitial()) {
    on<OnActorRequest>(onActorRequest);
  }

  final service = ActorService();

  FutureOr<void> onActorRequest(
    OnActorRequest event,
    Emitter<ActorsState> emit,
  ) async {
    try {
      emit(ActorsLoading());
      final result = await service.onActorRequested();
      if (result == null) {
        emit(ActorsFailed());
        return;
      }

      result.fold(
        (l) {
          if (l == null || l.isEmpty) {
            emit(ActorsFailed());
            return;
          }
          final result = actorsResponseFromMap(l);
          emit(ActorsLoaded(result: result));
        },
        (r) => emit(ActorsFailed()),
      );
    } catch (e) {
      emit(ActorsFailed());
    }
  }
}
