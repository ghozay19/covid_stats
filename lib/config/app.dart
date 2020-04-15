import 'package:covid_stats/config/theme_provider.dart';
import 'package:covid_stats/core/blocs/covid_blocs.dart';
import 'package:covid_stats/ui/dashboard_screen.dart';
import 'package:covid_stats/ui/detail_screen.dart';
import 'package:covid_stats/ui/shared/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CovidApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: themeProvider.getThemeData,
      home: DashboardScreen(),
//      home: DetailScreen(),
    );

  }
}
