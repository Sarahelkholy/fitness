import 'package:fitness/config/error_handling/execute_api.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/api/api_client/home_api_client.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/difficulty_level_response.dart';
import '../../data/models/exercise_response.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiClient _apiClient;

  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<DifficultyLevelResponse> getDifficultyLevels({
    String? primeMoverMuscleId,
  }) {
    return _apiClient.getDifficultyLevels(
      primeMoverMuscleId: primeMoverMuscleId,
    );
  }

  @override
  Future<ExerciseResponse> getExercises({
    String? primeMoverMuscleId,
    String? difficultyLevelId,
    int? page,
  }) {
    return _apiClient.getExercises(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
  }

  @override
  Future<Result<RandomExercisesResponse>> getRandomExercises() {
    return executeApi<RandomExercisesResponse>(() {
      return _apiClient.getRandomExercises();
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
