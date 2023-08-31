import 'package:cineket/helper/path.dart';
import 'package:cineket/now_showing/now_showing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NowShowing extends StatefulWidget {
  const NowShowing({
    super.key,
  });

  @override
  State<NowShowing> createState() => _NowShowingState();
}

class _NowShowingState extends State<NowShowing>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<NowShowingBloc, NowShowingState>(
      builder: (context, state) {
        if (state is NowShowingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowShowingLoaded) {
          final nowShowingMovie = state.result.results;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2 / 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: nowShowingMovie.length,
            itemBuilder: (context, index) => MovieCard(
              title: nowShowingMovie[index].originalTitle,
              backDropPath: nowShowingMovie[index].backdropPath,
              releaseDate: nowShowingMovie[index].releaseDate,
              rating: nowShowingMovie[index].voteAverage,
            ),
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          );
        } else if (state is NowShowingFailed) {
          return const Center(child: Text('Request Error'));
        } else {
          return const Center(child: Text('Something Went Wrong!'));
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
