import 'package:fitness/config/error_handling/execute_api.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/api/api_client/home_api_client.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiClient _apiClient;

  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<RandomExercisesResponse>> getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  }) {
    return executeApi<RandomExercisesResponse>(() {
      return _apiClient.getRandomExercises(
        targetMuscleGroupId: targetMuscleGroupId,
        difficultyLevelId: difficultyLevelId,
        limit: limit,
      );
    });
  }
}
