import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_exercises_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:fitness/config/di/di.dart';
import 'package:fitness/config/user/manager/user_cubit.dart';

import 'exercise_event.dart';
import 'exercise_state.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  final GetExercisesUseCase _getExercisesUseCase;
  final GetDifficultyLevelsUseCase _getDifficultyLevelsUseCase;

  ExerciseCubit(this._getExercisesUseCase, this._getDifficultyLevelsUseCase)
    : super(const ExerciseState());

  void doIntent(ExerciseEvent event) {
    switch (event) {
      case GetExercisesEvent():
        _getExercises(event);
      case GetDifficultyLevelsEvent():
        _getDifficultyLevels(event);
      case SelectExerciseEvent():
        _selectExercise(event);
      case SelectDifficultyLevelEvent():
        _selectDifficultyLevel(event);
    }
  }

  Future<void> _getExercises(GetExercisesEvent event) async {
    final pageToFetch = event.page ?? 1;
    final primeMoverId = event.primeMoverMuscleId ?? state.primeMoverMuscleId;

    emit(
      state.copyWith(
        exercisesState: pageToFetch == 1
            ? const BaseState(isLoading: true)
            : state.exercisesState.copyWith(isLoading: true, errorMessage: null),
        currentPage: pageToFetch == 1 ? 1 : state.currentPage,
        clearSelectedExercise: pageToFetch == 1,
      ),
    );

    final result = await _getExercisesUseCase(
      primeMoverMuscleId: primeMoverId,
      difficultyLevelId:
          event.difficultyLevelId ?? state.selectedDifficultyLevel?.id,
      page: pageToFetch,
    );

    switch (result) {
      case Success<ExerciseInfo>():
        final currentExercises = state.exercisesState.data ?? [];
        final newExercises = result.data.exercises ?? [];
        final allExercises = pageToFetch == 1
            ? newExercises
            : [...currentExercises, ...newExercises];

        final selected = _resolveSelectedExercise(allExercises, pageToFetch);

        emit(
          state.copyWith(
            exercisesState: BaseState(isSuccess: true, data: allExercises),
            currentPage: result.data.currentPage ?? pageToFetch,
            totalPages: result.data.totalPages ?? state.totalPages,
            selectedExercise: selected,
          ),
        );
      case Failure<ExerciseInfo>():
        emit(
          state.copyWith(
            exercisesState: state.exercisesState.copyWith(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _getDifficultyLevels(GetDifficultyLevelsEvent event) async {
    final initEx = event.initialExercise;
    emit(
      state.copyWith(
        difficultyLevelsState: const BaseState(isLoading: true),
        primeMoverMuscleId: event.primeMoverMuscleId,
        initialExercise: initEx,
        selectedExercise: initEx,
        initialExerciseId: event.initialExerciseId ?? initEx?.id,
        initialDifficultyLevel:
            event.initialDifficultyLevel ?? initEx?.difficultyLevel,
      ),
    );

    final result = await _getDifficultyLevelsUseCase(
      primeMoverMuscleId: event.primeMoverMuscleId,
    );

    switch (result) {
      case Success<List<DifficultyLevel>>():
        final levels = result.data;
        final selectedLevel = _resolveSelectedDifficultyLevel(levels);

        emit(
          state.copyWith(
            difficultyLevelsState:
                BaseState(isSuccess: true, data: levels),
            selectedDifficultyLevel: selectedLevel,
          ),
        );

        if (selectedLevel != null) {
          _getExercises(GetExercisesEvent(
            primeMoverMuscleId: event.primeMoverMuscleId,
            difficultyLevelId: selectedLevel.id,
          ));
        }
      case Failure<List<DifficultyLevel>>():
        emit(
          state.copyWith(
            difficultyLevelsState:
                BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  Exercise? _resolveSelectedExercise(
      List<Exercise> allExercises, int pageToFetch) {
    if (pageToFetch != 1 || allExercises.isEmpty) {
      return state.selectedExercise ?? state.initialExercise;
    }

    final targetId = state.initialExerciseId ?? state.initialExercise?.id;
    final targetName = state.initialExercise?.exercise;

    if ((targetId != null && targetId.isNotEmpty) ||
        (targetName != null && targetName.isNotEmpty)) {
      final matchedIndex = allExercises.indexWhere((e) =>
          (targetId != null && targetId.isNotEmpty && e.id == targetId) ||
          (targetName != null &&
              targetName.isNotEmpty &&
              e.exercise?.toLowerCase() == targetName.toLowerCase()));

      if (matchedIndex != -1) return allExercises[matchedIndex];
    }

    return state.selectedExercise ?? state.initialExercise ?? allExercises.first;
  }

  DifficultyLevel? _resolveSelectedDifficultyLevel(
      List<DifficultyLevel> levels) {
    if (levels.isEmpty) return null;

    final targetDiff =
        state.initialDifficultyLevel ?? state.initialExercise?.difficultyLevel;

    if (targetDiff != null && targetDiff.isNotEmpty) {
      final matchedIndex = levels.indexWhere(
        (l) =>
            l.id == targetDiff ||
            l.name?.toLowerCase() == targetDiff.toLowerCase(),
      );
      if (matchedIndex != -1) return levels[matchedIndex];
    }

    final user = getIt<UserCubit>().state.user;
    final userLevel = user?.activityLevel ?? '';
    if (userLevel.isNotEmpty) {
      final matchedIndex = levels.indexWhere(
        (l) =>
            l.id == userLevel ||
            (l.name?.toLowerCase().contains(userLevel.toLowerCase()) ?? false),
      );
      if (matchedIndex != -1) return levels[matchedIndex];
    }

    return levels.first;
  }

  void _selectExercise(SelectExerciseEvent event) {
    emit(state.copyWith(selectedExercise: event.exercise));
  }

  void _selectDifficultyLevel(SelectDifficultyLevelEvent event) {
    emit(
      state.copyWith(
        selectedDifficultyLevel: event.difficultyLevel,
        clearInitialExercise: true,
      ),
    );
    _getExercises(
        GetExercisesEvent(difficultyLevelId: event.difficultyLevel.id));
  }
}
