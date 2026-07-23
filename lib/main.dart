import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/config/user/manager/user_state.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/di/di.dart';
import 'config/route_manager/route_generator.dart';
import 'config/route_manager/routes.dart';
import 'core/helpers/custom_bloc_observer.dart';
import 'core/helpers/show_session_expired_dialog.dart';
import 'core/local_cubit/locale_cubit.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_constants.dart';
import 'core/values/app_strings.dart';
import 'features/exercise/domain/use_cases/get_exercises_use_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  Bloc.observer = CustomBlocObserver();

  final temp1 = getIt<GetDifficultyLevelsUseCase>();
  temp1(primeMoverMuscleId: "69d982ef85f6bfa972bf2248");
  final temp2 = getIt<GetExercisesUseCase>();
  temp2(
    primeMoverMuscleId: "69d982ef85f6bfa972bf2248",
    page: 1,
    difficultyLevelId: "69d982ed85f6bfa972bf2216",
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UserCubit>()),

        BlocProvider(create: (_) => getIt<LocaleCubit>()..loadSavedLanguage()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            navigatorKey: AppConstants.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Fitness APP',

            initialRoute: Routes.splashRoute,
            onGenerateRoute: RouteGenerator.getRoute,

            locale: locale,

            theme: AppTheme.appTheme(context),

            localizationsDelegates: AppLocalizations.localizationsDelegates,

            supportedLocales: AppLocalizations.supportedLocales,

            builder: (context, child) {
              AppStrings.current = AppLocalizations.of(context)!;

              return BlocListener<UserCubit, UserState>(
                listener: (context, state) {
                  if (state.isUnauthorized) {
                    showSessionExpiredDialog();
                  }
                },
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
