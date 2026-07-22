import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_entity.dart';

extension ExerciseModelMapper on Exercises {
  RandomExerciseEntity toEntity() {
    return RandomExerciseEntity(
      id: Id,
      exercise: exercise,
      difficultyLevel: difficultyLevel,
      targetMuscleGroup: targetMuscleGroup,
      primeMoverMuscle: primeMoverMuscle,
    );
  }
}
