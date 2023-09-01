import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineket/theme/theme.dart';
import 'package:cineket/tv_show/views/views.dart';
import 'package:flutter/material.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({super.key});

  @override
  State<TvShowScreen> createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  int activeIndex = 0;

  final List<Tab> _myTabs = const [
    Tab(text: 'Air Today'),
    Tab(text: 'On the Air'),
    Tab(text: 'Popular'),
    Tab(text: 'Top Rated'),
  ];

  final List<Widget> _children = [
    const TvAirTodayView(),
    const TvOnAirView(),
    const TvPopularView(),
    const TvTopRatedView(),
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
    return DefaultTabController(
      length: _myTabs.length,
      child: Scaffold(
        appBar: TabBar(
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
                  child: AutoSizeText(
                    activeIndex == _myTabs.indexOf(tab)
                        ? '\u2022  ${tab.text!}'
                        : tab.text!,
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
