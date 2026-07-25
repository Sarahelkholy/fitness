import '../../../domain/entities/difficulty_level.dart';
import '../../../domain/entities/exercise.dart';

sealed class ExerciseEvent {}

class GetExercisesEvent extends ExerciseEvent {
  final String? primeMoverMuscleId;
  final String? difficultyLevelId;
  final int? page;

  GetExercisesEvent({
    this.primeMoverMuscleId,
    this.difficultyLevelId,
    this.page,
  });
}

class GetDifficultyLevelsEvent extends ExerciseEvent {
  final String? primeMoverMuscleId;
  final Exercise? initialExercise;
  final String? initialExerciseId;
  final String? initialDifficultyLevel;

  GetDifficultyLevelsEvent({
    this.primeMoverMuscleId,
    this.initialExercise,
    this.initialExerciseId,
    this.initialDifficultyLevel,
  });
}

class SelectExerciseEvent extends ExerciseEvent {
  final Exercise exercise;

  SelectExerciseEvent(this.exercise);
}

class SelectDifficultyLevelEvent extends ExerciseEvent {
  final DifficultyLevel difficultyLevel;

  SelectDifficultyLevelEvent(this.difficultyLevel);
}
