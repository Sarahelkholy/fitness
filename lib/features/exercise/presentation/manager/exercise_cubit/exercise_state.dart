import 'package:equatable/equatable.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';

class ExerciseState extends Equatable {
  final BaseState<List<Exercise>> exercisesState;
  final BaseState<List<DifficultyLevel>> difficultyLevelsState;
  final Exercise? selectedExercise;
  final DifficultyLevel? selectedDifficultyLevel;
  final int currentPage;
  final int totalPages;
  final String? primeMoverMuscleId;
  final Exercise? initialExercise;
  final String? initialExerciseId;
  final String? initialDifficultyLevel;

  const ExerciseState({
    this.exercisesState = const BaseState(),
    this.difficultyLevelsState = const BaseState(),
    this.selectedExercise,
    this.selectedDifficultyLevel,
    this.currentPage = 1,
    this.totalPages = 0,
    this.primeMoverMuscleId,
    this.initialExercise,
    this.initialExerciseId,
    this.initialDifficultyLevel,
  });

  ExerciseState copyWith({
    BaseState<List<Exercise>>? exercisesState,
    BaseState<List<DifficultyLevel>>? difficultyLevelsState,
    Exercise? selectedExercise,
    bool? clearSelectedExercise,
    DifficultyLevel? selectedDifficultyLevel,
    int? currentPage,
    int? totalPages,
    String? primeMoverMuscleId,
    Exercise? initialExercise,
    String? initialExerciseId,
    String? initialDifficultyLevel,
    bool? clearInitialExercise,
  }) {
    final nextInitialExercise = (clearInitialExercise ?? false)
        ? null
        : (initialExercise ?? this.initialExercise);

    return ExerciseState(
      exercisesState: exercisesState ?? this.exercisesState,
      difficultyLevelsState:
          difficultyLevelsState ?? this.difficultyLevelsState,
      selectedExercise: (clearSelectedExercise ?? false)
          ? nextInitialExercise
          : (selectedExercise ?? this.selectedExercise ?? nextInitialExercise),
      selectedDifficultyLevel:
          selectedDifficultyLevel ?? this.selectedDifficultyLevel,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      primeMoverMuscleId: primeMoverMuscleId ?? this.primeMoverMuscleId,
      initialExercise: nextInitialExercise,
      initialExerciseId: (clearInitialExercise ?? false)
          ? null
          : (initialExerciseId ?? this.initialExerciseId),
      initialDifficultyLevel: (clearInitialExercise ?? false)
          ? null
          : (initialDifficultyLevel ?? this.initialDifficultyLevel),
    );
  }

  @override
  List<Object?> get props => [
    exercisesState,
    difficultyLevelsState,
    selectedExercise,
    selectedDifficultyLevel,
    currentPage,
    totalPages,
    primeMoverMuscleId,
    initialExercise,
    initialExerciseId,
    initialDifficultyLevel,
  ];
}
