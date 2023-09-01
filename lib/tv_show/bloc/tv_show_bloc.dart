import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cineket/tv_show/tv_show.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_event.dart';
part 'tv_show_state.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  TvShowBloc() : super(TvShowInitial()) {
    on<TvShowRequested>(onTvShowRequest);
  }
  final service = TvShowService();

  FutureOr<void> onTvShowRequest(
    TvShowRequested event,
    Emitter<TvShowState> emit,
  ) async {
    emit(TvShowLoading());
    final result = await service.onTvShowRequest(path: event.path);
    if (result == null) {
      emit(TvShowFailed());
      return;
    }

    result.fold(
      (l) {
        if (l == null) {
          emit(TvShowFailed());
          return;
        }

        final result = tvShowResFromJson(l);
        emit(TvShowLoaded(result: result));
      },
      (r) => emit(TvShowFailed()),
    );
  }
}
