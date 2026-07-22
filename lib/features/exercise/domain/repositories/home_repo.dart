import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';

abstract interface class HomeRepo {
  Future<Result<RandomExercisesResponseEntity>> getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  });
}
