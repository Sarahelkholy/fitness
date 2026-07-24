import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/shared_widgets/custom_tab_bar.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/exercise_cubit/exercise_cubit.dart';
import '../manager/exercise_cubit/exercise_event.dart';
import '../manager/exercise_cubit/exercise_state.dart';
import '../widgets/exercise_list_item.dart';
import '../widgets/selected_exercise_header.dart';

class ExerciseScreen extends StatefulWidget {
  final String primeMoverMuscleId;

  const ExerciseScreen({super.key, required this.primeMoverMuscleId});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late ExerciseCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ExerciseCubit>();
    _cubit.doIntent(
      GetDifficultyLevelsEvent(primeMoverMuscleId: widget.primeMoverMuscleId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppAssets.exerciseBackgroundBlur,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Exercise',
          style: AppTextStyles.bold18(context).copyWith(color: AppColors.white),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          if (state.difficultyLevelsState.isLoading &&
              state.difficultyLevelsState.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.main),
            );
          }

          return Column(
            children: [
              // Upper Section: Selected Exercise Info
              BlocBuilder<ExerciseCubit, ExerciseState>(
                buildWhen: (previous, current) =>
                    previous.selectedExercise != current.selectedExercise,
                builder: (context, state) {
                  final exercise = state.selectedExercise;
                  if (exercise == null) return const SizedBox.shrink();

                  return SelectedExerciseHeader(exercise: exercise);
                },
              ),

              const SizedBox(height: 16),

              // Tab Bar: Difficulty Levels
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: state.difficultyLevelsState.data != null
                    ? CustomTabBar(
                        tabs: state.difficultyLevelsState.data!
                            .map((e) => e.name ?? '')
                            .toList(),
                        selectedIndex: state.difficultyLevelsState.data!
                            .indexWhere(
                              (e) => e.id == state.selectedDifficultyLevel?.id,
                            ),
                        onTabChanged: (index) {
                          final selectedLevel =
                              state.difficultyLevelsState.data![index];
                          _cubit.doIntent(
                            SelectDifficultyLevelEvent(selectedLevel),
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 16),

              // Exercise List
              Expanded(
                child: state.exercisesState.isLoading &&
                        state.exercisesState.data == null
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColors.main),
                      )
                    : state.exercisesState.errorMessage != null &&
                            (state.exercisesState.data == null ||
                                state.exercisesState.data!.isEmpty)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                state.exercisesState.errorMessage!,
                                style: AppTextStyles.regular14(context)
                                    .copyWith(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: state.exercisesState.data?.length ?? 0,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final exercise =
                                  state.exercisesState.data![index];
                              return ExerciseListItem(
                                exercise: exercise,
                                isSelected:
                                    state.selectedExercise?.id == exercise.id,
                                onTap: () {
                                  _cubit
                                      .doIntent(SelectExerciseEvent(exercise));
                                },
                                onPlay: () {
                                  debugPrint(
                                    'Playing: ${exercise.shortYoutubeDemonstrationLink}',
                                  );
                                },
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}
