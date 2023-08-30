import 'package:cineket/now_showing/now_showing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NowShowing extends StatelessWidget {
  const NowShowing({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowShowingBloc, NowShowingState>(
      builder: (context, state) {
        if (state is NowShowingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowShowingLoaded) {
          final nowShowingMovie = state.result.results;
          return GridView.count(
            crossAxisCount: 2,
            semanticChildCount: 15,
            shrinkWrap: true,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 4.2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: List.generate(
              nowShowingMovie.length,
              (index) => MovieCard(
                title: nowShowingMovie[index].originalTitle,
                backDropPath: nowShowingMovie[index].backdropPath,
                releaseDate: nowShowingMovie[index].releaseDate,
                rating: nowShowingMovie[index].voteAverage,
              ),
            ),
          );
        } else if (state is NowShowingFailed) {
          return const Center(child: Text('Request Error'));
        } else {
          return const Center(child: Text('Something Went Wrong!'));
        }
      },
    );
  }
}
