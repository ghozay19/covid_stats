import 'package:covid_stats/config/app.dart';
import 'package:covid_stats/config/theme_provider.dart';
import 'package:covid_stats/core/blocs/covid_blocs.dart';
import 'package:covid_stats/core/model/user_location.dart';
import 'package:covid_stats/core/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
//  runApp(ChangeNotifierProvider(
//      create: (_) => ThemeProvider(isLightTheme: true),
//      child: CovidApps()));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(isDarkTheme: true),
      ),
      Provider<CovidBlocs>(
          create: (_) => CovidBlocs()),
      Provider<LoctService>(
        create: (_) => LoctService(),
      ),
      StreamProvider<UserLocation>(
        create: (_) => LoctService().locationStream,
      )
    ],
    child: CovidApps(),
  ));
}
