import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_cubit.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_state.dart';
import 'package:fitness/features/exercise/presentation/widgets/headline_widget.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/categories_list.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/recommendation_exercise_list.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/recommendation_food_list.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/upcoming_workouts_section.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/user_info_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return CustomScaffold(
      backgroundImage: AppAssets.exercisesBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserInfoBar(),
              const SizedBox(height: 24),
              HeadlineWidget(title: local.category),
              const CategoriesList(),
              const SizedBox(height: 24),

              HeadlineWidget(title: local.recommendationToDay),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeSuccess &&
                      state.randomExercisesResponseEntity != null) {
                    final exercisesList =
                        state.randomExercisesResponseEntity!.exercises ?? [];
                    return RecommendationExerciseList(exercises: exercisesList);
                  } else if (state is HomeFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 24),

              HeadlineWidget(title: local.upcomingWorkouts, isViewAll: true),
              const UpcomingWorkoutsSection(),
              const SizedBox(height: 24),

              HeadlineWidget(
                title: local.recommendationForYou,
                isViewAll: true,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeSuccess && state.foodCategories != null) {
                    final categoriesList = state.foodCategories!;
                    return RecommendationFoodList(categories: categoriesList);
                  } else if (state is HomeFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 24),

              HeadlineWidget(title: local.popularTraining),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
