import 'package:cineket/app/widgets/bottom_bar_inherited.dart';
import 'package:cineket/app/widgets/loading.dart';
import 'package:cineket/helper/genre_finder.dart';
import 'package:cineket/movie/movie.dart';
import 'package:cineket/tv_show/tv_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowView extends StatefulWidget {
  const TvShowView({
    super.key,
  });

  @override
  State<TvShowView> createState() => _TvShowState();
}

class _TvShowState extends State<TvShowView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _controller;
  late final BottomBarInherited? bottomBarInherited;
  late bool isScrollingDown;
  late bool isOnTop;

  @override
  void initState() {
    isScrollingDown = false;
    isOnTop = true;
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bottomBarInherited = BottomBarInherited.of(context);
    super.didChangeDependencies();
  }

  void listener() {
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          isOnTop = false;
          bottomBarInherited?.hideBottomBar();
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          isOnTop = true;
          bottomBarInherited?.showBottomBar();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<TvShowBloc, TvShowState>(
      builder: (context, state) {
        if (state is TvShowLoading) {
          return const CircularLoading();
        } else if (state is TvShowLoaded) {
          final tvShow = state.result.results;
          return GridView.builder(
            controller: _controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2 / 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: tvShow.length,
            itemBuilder: (context, index) {
              final genres = findTvShowGenreNames(tvShow[index].genreIds);
              return MovieCard(
                title: tvShow[index].name,
                posterPath: tvShow[index].posterPath,
                releaseDate: tvShow[index].firstAirDate,
                rating: tvShow[index].voteAverage,
                reviewer: tvShow[index].voteCount,
                genres: genres,
              );
            },
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          );
        } else if (state is TvShowFailed) {
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
