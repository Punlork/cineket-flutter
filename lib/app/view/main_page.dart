import 'package:cineket/app/widgets/bottom_bar_inherited.dart';
import 'package:cineket/app/widgets/custom_bottom_bar.dart';
import 'package:cineket/app/widgets/custom_box_shadow.dart';
import 'package:cineket/helper/helper.dart';
import 'package:cineket/movie/movie.dart';
import 'package:cineket/theme/theme.dart';
import 'package:cineket/tv_show/views/tv_show_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const appBarTitle = 'Welcome, Guys!';
    const appBarSubtitle =
        'There are lots of interesting movies to watch today!';

    return DefaultTabController(
      length: 3,
      child: CustomBottomBar(
        barColor: AppColors.backgroundColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(30),
        offset: 20,
        barDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.backgroundColor.withOpacity(.5),
          boxShadow: [
            CustomBoxShadow(
              color: AppColors.primary.withOpacity(.5),
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        body: (context, controller, showBottomBar, hideBottomBar) {
          return BottomBarInherited(
            hideBottomBar: hideBottomBar,
            showBottomBar: showBottomBar,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      SvgPath.TMDB_LOGO,
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          appBarTitle,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          appBarSubtitle,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MovieScreen(),
                  TvShowScreen(),
                  Text('Movies'),
                ],
              ),
            ),
          );
        },
        child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColors.primary,
            indicatorPadding: const EdgeInsets.only(bottom: 5),
            indicatorWeight: 1,
            labelColor: AppColors.primary,
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            unselectedLabelStyle:
                Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
            unselectedLabelColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            tabs: const [
              Tab(text: 'Movies'),
              Tab(text: 'Tv Show'),
              Tab(text: 'Actors'),
            ],
          ),
        ),
      ),
    );
  }
}
