import 'package:cineket/helper/helper.dart';
import 'package:cineket/movie/views/movie_view.dart';
import 'package:cineket/tv_show/tv_show.dart';
import 'package:cineket/tv_show/views/tv_show_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvAirTodayView extends StatelessWidget {
  const TvAirTodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvShowBloc()
        ..add(
          const TvShowRequested(
            path: ApiPath.TV_AIR_TODAY,
          ),
        ),
      child: const TvShowView(),
    );
  }
}
