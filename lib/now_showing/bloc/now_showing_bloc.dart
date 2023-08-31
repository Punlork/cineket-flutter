import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cineket/helper/object_logger.dart';
import 'package:cineket/helper/path.dart';
import 'package:cineket/now_showing/models/response.dart';
import 'package:cineket/now_showing/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'now_showing_event.dart';
part 'now_showing_state.dart';

class NowShowingBloc extends Bloc<NowShowingEvent, NowShowingState> {
  NowShowingBloc() : super(NowShowingInitial()) {
    on<NowShowingRequested>(onNowShowingRequested);
  }

  final services = NowShowingService();

  FutureOr<void> onNowShowingRequested(
    NowShowingRequested event,
    Emitter<NowShowingState> emit,
  ) async {
    emit(NowShowingLoading());
    final results = await services.nowShowingRequest(path: event.path);

    if (results == null) {
      emit(NowShowingFailed());
      return;
    }

    results.fold(
      (l) {
        if (l == null) {
          emit(NowShowingFailed());
          return;
        }
        emit(NowShowingLoaded(result: nowShowingResFromJson(l)));
      },
      (r) => emit(NowShowingFailed()),
    );
  }
}
