import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/helpers/custom_logger.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_cubit.dart';
import 'package:fitness/features/auth/presentation/pages/register/register_screen.dart';
import 'package:fitness/features/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localization/l10n/app_localizations.dart';
import '../../features/auth/presentation/pages/register_form/register_form_screen.dart';
import '../di/di.dart';

abstract class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        /// home screen
        case Routes.homeRoute:
          return MaterialPageRoute(builder: (_) => const HomeScreen());

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
