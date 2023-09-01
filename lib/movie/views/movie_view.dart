import 'package:cineket/app/widgets/bottom_bar_inherited.dart';
import 'package:cineket/movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieView extends StatefulWidget {
  const MovieView({
    super.key,
  });

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView>
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

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieLoaded) {
          final nowShowingMovie = state.result.results;
          return GridView.builder(
            controller: _controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2 / 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: nowShowingMovie.length,
            itemBuilder: (context, index) => MovieCard(
              title: nowShowingMovie[index].title,
              posterPath: nowShowingMovie[index].posterPath,
              releaseDate: nowShowingMovie[index].releaseDate,
              rating: nowShowingMovie[index].voteAverage,
              reviewer: nowShowingMovie[index].voteCount,
              genreIds: nowShowingMovie[index].genreIds,
            ),
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          );
        } else if (state is MovieFailed) {
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
