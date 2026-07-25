import 'package:fitness/core/values/api_end_points.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:fitness/features/exercise/data/models/exercise_response.dart';
import 'package:injectable/injectable.dart';
part 'random_exercise_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class RandomExerciseApiClient {
  @factoryMethod
  factory RandomExerciseApiClient(Dio dio) => _RandomExerciseApiClient(dio);
  @GET(ApiEndPoints.getRandomPrimeMoverMusclesEndpoint)
  Future<ExerciseResponse> getRandomExercises({
    @Query("targetMuscleGroupId") required String targetMuscleGroupId,
    @Query("difficultyLevelId") required String difficultyLevelId,
    @Query("limit") int limit = 5,
  });
}
