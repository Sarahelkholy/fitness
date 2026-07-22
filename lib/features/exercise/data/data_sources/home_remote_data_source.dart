import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';

abstract interface class HomeRemoteDataSource {
  Future<Result<RandomExercisesResponse>> getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  });
}
