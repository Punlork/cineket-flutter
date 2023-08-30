import 'package:cineket/app/app.dart';
import 'package:cineket/l10n/l10n.dart';
import 'package:cineket/now_showing/now_showing.dart';
import 'package:cineket/theme/theme.dart';
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
        home: BlocProvider(
          create: (context) => NowShowingBloc()..add(NowShowingRequested()),
          child: const MainPage(),
        ),
      ),
    );
  }
}
