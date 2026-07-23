import 'package:fitness/config/error_handling/execute_api.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/api/api_client/home_api_client.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';
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

  ///? ========= Get All Muscles Group ============
  @override
  Future<Result<GetAllMusclesGroupResponse>> getAllMusclesGroup({
    required String language,
  }) {
    return executeApi(() async {
      return await _apiClient.getAllMusclesGroup(language);
    });
  }

  ///? ================= Get Muscle Using id ===================
  @override
  Future<Result<GetMusclesGroupIdResponse>> getMuscleGroupId({
    required String language,
    required String muscleGroupId,
  }) async {
    return executeApi(() async {
      return await _apiClient.getMuscleGroupId(language, muscleGroupId);
    });
  }
}
