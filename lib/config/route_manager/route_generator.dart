import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/helpers/custom_logger.dart';
import 'package:fitness/core/shared_widgets/custom_bottom_nav.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:fitness/features/auth/presentation/pages/forget_password/view/screens/password_enter_email_screen.dart';
import 'package:fitness/features/auth/presentation/pages/login/login_screen.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_cubit.dart';
import 'package:fitness/features/auth/presentation/pages/register/register_screen.dart';
import 'package:fitness/features/chat_screen.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_cubit.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_events.dart';
import 'package:fitness/features/exercise/presentation/pages/home_screen.dart';
import 'package:fitness/features/exercise/presentation/pages/upcoming_feature_screen.dart';
import 'package:fitness/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:fitness/features/exercise/presentation/pages/exercise_screen.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_event.dart';
import 'package:fitness/features/popular_tarining/presentation/view/popular_training_screen.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/di/di.dart';
import '../../core/localization/l10n/app_localizations.dart';
import '../../features/auth/presentation/pages/onboarding/view/on_boarding_screen.dart';
import '../../features/auth/presentation/pages/register_form/register_form_screen.dart';
import '../../features/auth/presentation/pages/splash/splash_screen.dart';
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
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<HomeCubit>(),
              child: const HomeScreen(),
            ),
          );

        case Routes.forgetPasswordRoute:
          return MaterialPageRoute(
            builder: (_) => const ForgetPasswordScreen(),
          );

        ///================ OnBoardingScreen ================
        case Routes.onboardingRoute:
          return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

        /// login screen
        case Routes.loginRoute:
          return MaterialPageRoute(
            builder: (_) => BlocProvider<LoginCubit>(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            ),
          );

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

        ///
        case Routes.popularTrainingRoute:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<PopularTrainingCubit>(),
              child: const PopularTrainingScreen(),
            ),
          );

        case Routes.bottomNavBarRoute:
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<HomeCubit>()
                ..doEvents(GetRandomExercises())
                ..doEvents(GetFoodCategories()),
              child: CustomBottomNavBar(
                initialIndex: args?['initialIndex'] ?? 0,
              ),
            ),
          );

        case Routes.smartCoachRoute:
          return MaterialPageRoute(builder: (_) => const ChatScreen());

        case Routes.upcomingFeatureRoute:
          return MaterialPageRoute(
            builder: (_) => const UpcomingFeatureScreen(),
          );

        /// exercise screen
        case Routes.exerciseRoute:
          final args = settings.arguments as Map<String, dynamic>?;
          final initialExercise = args?['initialExercise'] as Exercise?;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<ExerciseCubit>(),
              child: ExerciseScreen(
                primeMoverMuscleId: args?['primeMoverMuscleId'] ?? '',
                initialExercise: initialExercise,
                initialExerciseId:
                    args?['exerciseId'] ??
                    args?['initialExerciseId'] ??
                    initialExercise?.id,
                initialDifficultyLevel:
                    args?['difficultyLevel'] ??
                    initialExercise?.difficultyLevel,
              ),
            ),
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
