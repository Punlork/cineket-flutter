import 'package:cineket/app/widgets/custom_box_shadow.dart';
import 'package:cineket/movie/movie.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BottomBar(
        barColor: AppColors.backgroundColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(30),
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
        body: (context, controller) => const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            MovieScreen(),
            Text('Movies'),
            Text('Movies'),
          ],
        ),
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
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            unselectedLabelStyle:
                Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
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
