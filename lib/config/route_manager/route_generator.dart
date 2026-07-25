import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/helpers/custom_logger.dart';
import 'package:fitness/core/shared_widgets/custom_bottom_nav.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:fitness/features/auth/presentation/pages/login/login_screen.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_cubit.dart';
import 'package:fitness/features/auth/presentation/pages/register/register_screen.dart';
import 'package:fitness/features/exercise/presentation/pages/home_screen.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/di/di.dart';
import '../../core/localization/l10n/app_localizations.dart';
import '../../features/auth/presentation/pages/onboarding/view/on_boarding_screen.dart';
import '../../features/auth/presentation/pages/splash/splash_screen.dart';
import '../../features/auth/presentation/pages/register_form/register_form_screen.dart';
import '../../features/meals/presentation/manager/meal_details_cubit/meal_details_cubit.dart';
import '../../features/meals/presentation/manager/meal_details_cubit/meal_details_event.dart';
import '../../features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_cubit.dart';
import '../../features/meals/presentation/pages/meal_details_screen.dart';
import '../../features/meals/presentation/pages/meal_recommendation_screen.dart';

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

        /// login screen
        case Routes.loginRoute:
          return MaterialPageRoute(
            builder: (_) => BlocProvider<LoginCubit>(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            ),
          );

        ///================ OnBoardingScreen ================
        case Routes.onboardingRoute:
          return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

        /// register screen
        case Routes.registerRoute:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<RegisterCubit>(),
              child: const RegisterScreen(),
            ),
          );

        /// register form screen
        case Routes.registerFormRoute:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<RegisterFormCubit>(),
              child: const RegisterFormScreen(),
            ),
          );

        /// bottom nav bar screen
        case Routes.bottomNavBarRoute:
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (_) =>
                CustomBottomNavBar(initialIndex: args?['initialIndex'] ?? 0),
          );

        /// meal recommendation screen
        case Routes.mealRecommendationRoute:
          final index = settings.arguments as int? ?? 0;

          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<MealRecommendationCubit>()
                    ..doEvents(GetCategoriesEvent(initialIndex: index)),
              child: MealRecommendationScreen(initialIndex: index),
            ),
          );

        /// meal details screen
        case Routes.mealDetailsRoute:
          final mealId = settings.arguments as String;

          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<MealDetailsCubit>()
                    ..doEvents(GetMealDetailsEvent(mealId: mealId)),
              child: MealDetailsScreen(mealId: mealId),
            ),
          );

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
