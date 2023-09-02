import 'package:cineket/helper/path.dart';
import 'package:cineket/tv_show/tv_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvOnAirView extends StatelessWidget {
  const TvOnAirView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvShowBloc()
        ..add(
          const TvShowRequested(
            path: ApiPath.TV_ON_AIR,
          ),
        ),
      child: const TvShowView(),
    );
  }
}
