import 'package:cineket/now_showing/views/now_showing.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
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
    const NowShowing(),
    const Text('Popular'),
    const Text('Top Rated'),
    const Text('Up Coming'),
  ];

  void _tabListener() {
    if (_tabController.indexIsChanging) {
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
