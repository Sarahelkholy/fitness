import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/values/api_end_points.dart';
import '../../../../core/values/api_strings.dart';
import '../../data/models/difficulty_level_response.dart';
import '../../data/models/exercise_response.dart';

part 'home_api_client.g.dart';

@injectable
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApiEndPoints.exercisesByMuscleDifficulty)
  Future<ExerciseResponse> getExercises({
    @Query(ApiStrings.primeMoverMuscleId) String? primeMoverMuscleId,
    @Query(ApiStrings.difficultyLevelId) String? difficultyLevelId,
    @Query(ApiStrings.page) int? page,
  });

  @GET(ApiEndPoints.difficultyLevels)
  Future<DifficultyLevelResponse> getDifficultyLevels({
    @Query(ApiStrings.primeMoverMuscleId) String? primeMoverMuscleId,
  });
}
