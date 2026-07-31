import '../../../../config/error_handling/result.dart';
import '../entities/difficulty_level.dart';
import '../entities/exercise_info.dart';

abstract interface class HomeRepo {
  Future<Result<ExerciseInfo>> getExercises({
    String? primeMoverMuscleId,
    String? difficultyLevelId,
    int? page,
  });
  Future<Result<List<DifficultyLevel>>> getDifficultyLevels({
    String? primeMoverMuscleId,
  });
}
