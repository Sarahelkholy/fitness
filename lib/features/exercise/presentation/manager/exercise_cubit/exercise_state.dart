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

  const ExerciseState({
    this.exercisesState = const BaseState(),
    this.difficultyLevelsState = const BaseState(),
    this.selectedExercise,
    this.selectedDifficultyLevel,
    this.currentPage = 1,
    this.totalPages = 0,
    this.primeMoverMuscleId,
  });

  ExerciseState copyWith({
    BaseState<List<Exercise>>? exercisesState,
    BaseState<List<DifficultyLevel>>? difficultyLevelsState,
    Exercise? selectedExercise,
    DifficultyLevel? selectedDifficultyLevel,
    int? currentPage,
    int? totalPages,
    String? primeMoverMuscleId,
  }) {
    return ExerciseState(
      exercisesState: exercisesState ?? this.exercisesState,
      difficultyLevelsState: difficultyLevelsState ?? this.difficultyLevelsState,
      selectedExercise: selectedExercise ?? this.selectedExercise,
      selectedDifficultyLevel: selectedDifficultyLevel ?? this.selectedDifficultyLevel,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      primeMoverMuscleId: primeMoverMuscleId ?? this.primeMoverMuscleId,
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
      ];
}
