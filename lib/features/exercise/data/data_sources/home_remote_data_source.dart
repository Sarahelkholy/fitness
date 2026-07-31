import '../models/difficulty_level_response.dart';
import '../models/exercise_response.dart';

abstract interface class HomeRemoteDataSource {
  Future<ExerciseResponse> getExercises({
    String? primeMoverMuscleId,
    String? difficultyLevelId,
    int? page,
  });
  Future<DifficultyLevelResponse> getDifficultyLevels({
    String? primeMoverMuscleId,
  });
}
