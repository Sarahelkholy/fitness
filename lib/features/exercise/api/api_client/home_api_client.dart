import 'package:dio/dio.dart';
import 'package:fitness/core/values/api_end_points.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/values/api_strings.dart';
import '../../data/models/difficulty_level_response.dart';
import '../../data/models/exercise_response.dart';

part 'home_api_client.g.dart';

@injectable
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApiEndPoints.randomExercises)
  Future<RandomExercisesResponse> getRandomExercises({
    @Query("targetMuscleGroupId") required String targetMuscleGroupId,
    @Query("difficultyLevelId") required String difficultyLevelId,
    @Query("limit") int limit = 3,
  });

  ///? ============= Get All Muscles Group =================
  @GET(ApiEndPoints.getAllMusclesGroup)
  Future<GetAllMusclesGroupResponse> getAllMusclesGroup(
    @Header('accept-language') String language,
  );

  ///? ================= Get Muscle Using id ===================
  @GET(ApiEndPoints.getMuscleGroupId)
  Future<GetMusclesGroupIdResponse> getMuscleGroupId(
    @Header('accept-language') String language,
    @Query('muscleGroupId') String muscleGroupId,
  );
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
