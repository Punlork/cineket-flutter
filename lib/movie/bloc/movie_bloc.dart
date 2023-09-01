import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cineket/movie/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieRequested>(onNowShowingRequested);
  }

  final services = MovieService();

  FutureOr<void> onNowShowingRequested(
    MovieRequested event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    final results = await services.onMovieRequest(path: event.path);

    if (results == null) {
      emit(MovieFailed());
      return;
    }

    results.fold(
      (l) {
        if (l == null) {
          emit(MovieFailed());
          return;
        }
        emit(MovieLoaded(result: nowShowingResFromJson(l)));
      },
      (r) => emit(MovieFailed()),
    );
  }
}
