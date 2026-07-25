import 'dart:math';

import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_exercises_use_case.dart';
import 'package:fitness/features/popular_tarining/domain/models/popular_training_item.dart';
import 'package:fitness/features/popular_tarining/domain/use_cases/get_random_exercise_use_case.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class PopularTrainingCubit extends BaseCubit<PopularTrainingStates, BaseEvent> {
  final GetRandomExerciseUseCase _getRandomExerciseUseCase;
  final GetExercisesUseCase _getExercisesUseCase;
  final GetDifficultyLevelsUseCase _getDifficultyLevelsUseCase;

  PopularTrainingCubit(
    this._getRandomExerciseUseCase,
    this._getExercisesUseCase,
    this._getDifficultyLevelsUseCase,
  ) : super(const PopularTrainingStates());

  void doEvents(PopularTrainingIntents intent) {
    switch (intent) {
      case LoadPopularTrainingIntent():
        _loadPopularTraining();
        break;
    }
  }

  Future<void> _loadPopularTraining() async {
    emit(state.copyWith(isLoading: true));

    final musclesResult = await _getRandomExerciseUseCase
        .getRandomPrimeMoverMuscles();

    switch (musclesResult) {
      case Success():
        final muscles = musclesResult.data;
        if (muscles.isEmpty) {
          emit(
            state.copyWith(isLoading: false, errorMessage: 'No muscles found'),
          );
          return;
        }

        final random = Random();
        final shuffledMuscles = List<String>.from(muscles)..shuffle(random);
        final selectedMuscles = shuffledMuscles.take(6).toList();
        final List<PopularTrainingItem> trainingItems = [];

        for (final muscleId in selectedMuscles) {
          if (isClosed) return;

          try {
            final levelsResult = await _getDifficultyLevelsUseCase(
              primeMoverMuscleId: muscleId,
            );

            List<DifficultyLevel> levels = [];
            if (levelsResult is Success<List<DifficultyLevel>>) {
              levels = levelsResult.data;
            }

            int exerciseCount = 0;
            final String displayLevel = levels.isNotEmpty
                ? levels[random.nextInt(levels.length)].name ?? 'All Levels'
                : 'All Levels';

            Exercise? randomExercise;

            if (levels.isNotEmpty) {
              final firstLevelId = levels.first.id;
              final exerciseResult = await _getExercisesUseCase(
                primeMoverMuscleId: muscleId,
                difficultyLevelId: firstLevelId,
              );

              if (exerciseResult is Success<ExerciseInfo>) {
                final exerciseInfo = exerciseResult.data;
                exerciseCount = exerciseInfo.totalExercises ?? 0;
                final exercises = exerciseInfo.exercises;
                if (exercises != null && exercises.isNotEmpty) {
                  randomExercise = exercises[random.nextInt(exercises.length)];
                }
              }
            }

            if (randomExercise != null) {
              trainingItems.add(
                PopularTrainingItem(
                  exercise: randomExercise,
                  levels: levels,
                  exerciseCount: exerciseCount,
                  displayLevel: displayLevel,
                ),
              );
            }
          } catch (_) {
            continue;
          }
        }

        if (isClosed) return;
        emit(state.copyWith(isLoading: false, data: trainingItems));
        break;

      case Failure():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: musclesResult.errorMessage,
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: musclesResult.errorMessage));
        break;
    }
  }
}
