import 'package:fitness/config/di/di.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_tab_bar.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_cubit.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_event.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_state.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/shimmer/tabs_shimmer.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/shimmer/upcoming_workouts_list_shimmer.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/upcoming_workout_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingWorkoutsSection extends StatefulWidget {
  const UpcomingWorkoutsSection({super.key});

  @override
  State<UpcomingWorkoutsSection> createState() =>
      _UpcomingWorkoutsSectionState();
}

class _UpcomingWorkoutsSectionState extends State<UpcomingWorkoutsSection> {
  int _selectedIndex = 0;
  bool _isInitialSelectionDone = false;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<MusclesCubit>()
        ..doEvents(GetAllMusclesEvent(language: AppStrings.current.localeName)),
      child: BlocBuilder<MusclesCubit, MusclesState>(
        builder: (context, state) {
          final musclesGroupState = state.musclesGroupsState;
          final musclesGroups = musclesGroupState.data ?? [];
          final musclesByGroupState = state.workoutsState;

          if (musclesGroups.isNotEmpty && !_isInitialSelectionDone) {
            final abdominalIndex = musclesGroups.indexWhere(
              (e) => e.name?.toLowerCase().contains('abdominal') ?? false,
            );
            if (abdominalIndex != -1) {
              _selectedIndex = abdominalIndex;
            }
            _isInitialSelectionDone = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (musclesGroupState.isLoading == true)
                const TabsShimmer()
              else if (musclesGroupState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Error: ${musclesGroupState.errorMessage}',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
              else if (musclesGroups.isNotEmpty)
                CustomTabBar(
                  tabs: musclesGroups.map((e) => e.name ?? '').toList(),
                  selectedIndex: _selectedIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    final selectedGroup = musclesGroups[index];
                    context.read<MusclesCubit>().doEvents(
                      GetWorkoutsByMuscleGroupIdEvent(
                        language: AppStrings.current.localeName,
                        muscleGroupId: selectedGroup.id ?? '',
                        index: index,
                      ),
                    );
                  },
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    local.noMuscleGroupsAvailable,
                    style: AppTextStyles.regular14(context),
                  ),
                ),
              const SizedBox(height: 16),
              if (musclesByGroupState.isLoading == true)
                const UpcomingWorkoutsListShimmer()
              else if (musclesByGroupState.errorMessage != null)
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      'Error: ${musclesByGroupState.errorMessage}',
                      style: AppTextStyles.regular14(
                        context,
                      ).copyWith(color: AppColors.error, fontSize: 12),
                    ),
                  ),
                )
              else if (musclesByGroupState.data != null &&
                  musclesByGroupState.data!.isNotEmpty)
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: musclesByGroupState.data!.length,
                    itemBuilder: (context, index) {
                      final exercise = musclesByGroupState.data![index];
                      return GestureDetector(
                        onTap: () {
                          if (exercise.id != null && exercise.id!.isNotEmpty) {
                            Navigator.pushNamed(
                              context,
                              Routes.exerciseRoute,
                              arguments: {'primeMoverMuscleId': exercise.id!},
                            );
                          }
                        },
                        child: UpcomingWorkoutCard(
                          image: exercise.image,
                          title: exercise.name ?? '',
                        ),
                      );
                    },
                  ),
                )
              else if (musclesByGroupState.isSuccess == true)
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      local.noExercisesFoundForThisCategory,
                      style: AppTextStyles.regular14(context),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
