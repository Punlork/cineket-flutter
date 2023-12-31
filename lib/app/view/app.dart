import 'package:cineket/actors/actors.dart';
import 'package:cineket/app/app.dart';
import 'package:cineket/l10n/l10n.dart';
import 'package:cineket/movie/bloc/bloc.dart';
import 'package:cineket/theme/theme.dart';
import 'package:cineket/tv_show/tv_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      location: BannerLocation.topEnd,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MovieBloc(),
            ),
            BlocProvider(
              create: (context) => TvShowBloc(),
            ),
            BlocProvider(
              create: (context) => ActorsBloc()..add(OnActorRequest()),
            ),
          ],
          child: const MainPage(),
        ),
      ),
    );
  }
}
