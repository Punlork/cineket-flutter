import 'package:cineket/helper/path.dart';
import 'package:cineket/movie/views/now_showing.dart';
import 'package:cineket/movie/views/popular.dart';
import 'package:cineket/movie/views/top_rated.dart';
import 'package:cineket/movie/views/up_coming.dart';
import 'package:cineket/now_showing/now_showing.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  int activeIndex = 0;

  final List<Tab> _myTabs = const [
    Tab(text: 'Now Showing'),
    Tab(text: 'Popular'),
    Tab(text: 'Top Rated'),
    Tab(text: 'Up Coming'),
  ];

  final List<Widget> _children = [
    const NowShowingView(),
    const PopularView(),
    const TopRatedView(),
    const UpComingView(),
  ];

  void _tabListener() {
    if (!_tabController.indexIsChanging) {
      print(_tabController.indexIsChanging);
      setState(() {
        activeIndex = _tabController.index;
      });
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: _myTabs.length, vsync: this)
      ..addListener(_tabListener);
    super.initState();
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_tabListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const appBarTitle = 'Welcome, Guys!';
    const appBarSubtitle =
        'There are lots of interesting movies to watch today!';

    return DefaultTabController(
      length: _myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appBarTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                appBarSubtitle,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          actions: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: _myTabs
                .map<Widget>(
                  (tab) => Tab(
                    child: Text(
                      activeIndex == _myTabs.indexOf(tab)
                          ? '\u2022  ${tab.text!}'
                          : tab.text!,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _children,
        ),
      ),
    );
  }
}
