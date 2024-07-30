import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineket/app/widgets/bottom_bar_inherited.dart';
import 'package:cineket/movie/views/now_showing.dart';
import 'package:cineket/movie/views/popular.dart';
import 'package:cineket/movie/views/top_rated.dart';
import 'package:cineket/movie/views/up_coming.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with SingleTickerProviderStateMixin {
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
      setState(() {
        activeIndex = _tabController.index;
      });
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: _myTabs.length, vsync: this)..addListener(_tabListener);
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
    return DefaultTabController(
      length: _myTabs.length,
      child: Scaffold(
        appBar: TabBar(
          isScrollable: true,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          tabs: _myTabs
              .map<Widget>(
                (tab) => Tab(
                  child: AutoSizeText(
                    activeIndex == _myTabs.indexOf(tab) ? '\u2022  ${tab.text!}' : tab.text!,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _children,
        ),
      ),
    );
  }
}
