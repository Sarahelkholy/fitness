import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/mapper/difficulty_level_mapper.dart';
import 'package:fitness/features/exercise/data/mapper/exercise_response_mapper.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepoImpl(this._remoteDataSource);

  @override
  Future<Result<List<DifficultyLevel>>> getDifficultyLevels({
    String? primeMoverMuscleId,
  }) async {
    try {
      final response = await _remoteDataSource.getDifficultyLevels(
        primeMoverMuscleId: primeMoverMuscleId,
      );
      final entities =
          response.difficultyLevels?.map((e) => e.toEntity()).toList() ?? [];
      return Success(data: entities);
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<Result<ExerciseInfo>> getExercises({
    String? primeMoverMuscleId,
    String? difficultyLevelId,
    int? page,
  }) async {
    try {
      final response = await _remoteDataSource.getExercises(
        primeMoverMuscleId: primeMoverMuscleId,
        difficultyLevelId: difficultyLevelId,
        page: page,
      );
      return Success(data: response.toEntity());
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }
}
