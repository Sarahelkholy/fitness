import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/difficulty_level_response.dart';
import '../../data/models/exercise_response.dart';
import '../api_client/home_api_client.dart';

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
}
