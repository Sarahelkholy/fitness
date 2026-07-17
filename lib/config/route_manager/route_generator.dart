import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/helpers/custom_logger.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/home_screen.dart';
import 'package:flutter/material.dart';

import '../../core/localization/l10n/app_localizations.dart';
import '../../features/auth/presentation/pages/onboarding/view/on_boarding_screen.dart';
import '../../features/auth/presentation/pages/splash/splash_screen.dart';

abstract class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {

        /// Splash Screen
        case Routes.splashRoute:
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        /// home screen
        case Routes.homeRoute:
          return MaterialPageRoute(builder: (_) => const HomeScreen());

        ///================ OnBoardingScreen ================
        case Routes.onboardingRoute:
          return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

        /// Default
        default:
          return _errorRoute();
      }
    } catch (e, stackTrace) {
      CustomLogger.bgRed("Route error: $e");
      CustomLogger.bgRed("$stackTrace");

      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(
            AppLocalizations.of(context)!.pageNotFound,
            style: AppTextStyles.bold20(context),
          ),
        ),
      ),
    );
  }
}
