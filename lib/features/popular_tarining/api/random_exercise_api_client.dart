import 'package:fitness/core/values/api_end_points.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
part 'random_exercise_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class RandomExerciseApiClient {
  @factoryMethod
  factory RandomExerciseApiClient(Dio dio) => _RandomExerciseApiClient(dio);
  @GET(ApiEndPoints.getRandomPrimeMoverMusclesEndpoint)
  Future<List<String>> getRandomPrimeMoverMuscles();
}
