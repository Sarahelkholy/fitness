import 'package:fitness/config/route_manager/route_generator.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',

      initialRoute: Routes.homeRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: AppTheme.appTheme(context),

      localizationsDelegates: AppLocalizations.localizationsDelegates,

      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
