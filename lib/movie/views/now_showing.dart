import 'package:cineket/helper/path.dart';
import 'package:cineket/movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowShowingView extends StatelessWidget {
  const NowShowingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()
        ..add(
          MovieRequested(
            path: ApiPath.MOVIE_NOW_PLAY,
          ),
        ),
      child: const MovieView(),
    );
  }
}
