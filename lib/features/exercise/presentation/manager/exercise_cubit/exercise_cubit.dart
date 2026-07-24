import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_exercises_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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

    if (pageToFetch == 1) {
      emit(
        state.copyWith(
          exercisesState: const BaseState(isLoading: true),
          currentPage: 1,
        ),
      );
    } else {
      emit(
        state.copyWith(
          exercisesState: state.exercisesState.copyWith(
            isLoading: true,
            errorMessage: null,
          ),
        ),
      );
    }

    final result = await _getExercisesUseCase(
      primeMoverMuscleId: primeMoverId,
      difficultyLevelId: event.difficultyLevelId ?? state.selectedDifficultyLevel?.id,
      page: pageToFetch,
    );

    switch (result) {
      case Success<ExerciseInfo>():
        final currentExercises = state.exercisesState.data ?? [];
        final newExercises = result.data.exercises ?? [];
        final allExercises = pageToFetch == 1 ? newExercises : [...currentExercises, ...newExercises];

        emit(
          state.copyWith(
            exercisesState: BaseState(
              isSuccess: true,
              data: allExercises,
            ),
            currentPage: result.data.currentPage ?? pageToFetch,
            totalPages: result.data.totalPages ?? state.totalPages,
            selectedExercise: pageToFetch == 1 && allExercises.isNotEmpty ? allExercises.first : state.selectedExercise,
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
    emit(
      state.copyWith(
        difficultyLevelsState: const BaseState(isLoading: true),
        primeMoverMuscleId: event.primeMoverMuscleId,
      ),
    );

    final result = await _getDifficultyLevelsUseCase(
      primeMoverMuscleId: event.primeMoverMuscleId,
    );

    switch (result) {
      case Success<List<DifficultyLevel>>():
        final levels = result.data;
        emit(
          state.copyWith(
            difficultyLevelsState: BaseState(
              isSuccess: true,
              data: levels,
            ),
            selectedDifficultyLevel: levels.isNotEmpty ? levels.first : null,
          ),
        );
        if (levels.isNotEmpty) {
          _getExercises(GetExercisesEvent(
            primeMoverMuscleId: event.primeMoverMuscleId,
            difficultyLevelId: levels.first.id,
          ));
        }
      case Failure<List<DifficultyLevel>>():
        emit(
          state.copyWith(
            difficultyLevelsState: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  void _selectExercise(SelectExerciseEvent event) {
    emit(state.copyWith(selectedExercise: event.exercise));
  }

  void _selectDifficultyLevel(SelectDifficultyLevelEvent event) {
    emit(state.copyWith(selectedDifficultyLevel: event.difficultyLevel));
    _getExercises(GetExercisesEvent(
      difficultyLevelId: event.difficultyLevel.id,
    ));
  }
}
