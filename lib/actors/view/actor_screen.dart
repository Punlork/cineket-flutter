import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineket/actors/actors.dart';
import 'package:cineket/actors/widget/actor_card.dart';
import 'package:cineket/app/widgets/bottom_bar_inherited.dart';
import 'package:cineket/app/widgets/loading.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({super.key});

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
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
  void dispose() {
    _controller
      ..dispose()
      ..removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActorsBloc, ActorsState>(
      builder: (context, state) {
        if (state is ActorsInitial || state is ActorsLoading) {
          return const CircularLoading();
        } else if (state is ActorsLoaded) {
          final actors = state.result.results;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            controller: _controller,
            itemBuilder: (context, index) {
              final baseImageUrl =
                  FlavorConfig.instance.variables['baseImageUrl'];
              final actor = actors[index];
              final profileUrl = '$baseImageUrl${actor.profilePath}';
              return ActorCard(
                profileUrl: profileUrl,
                name: actor.name,
                knownForDepartment: actor.knownForDepartment,
                popularity: actor.popularity,
                knownFor: actor.knownFor,
              );
            },
            itemCount: actors.length,
          );
        } else if (state is ActorsFailed) {
          return const Text('Request Failed');
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
