import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/mappers/get_all_muscles_group_mapper.dart';
import 'package:fitness/features/exercise/data/mappers/get_muscle_group_id_mapper.dart';
import 'package:fitness/features/exercise/data/mappers/home/random_exercises_response_mapper.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';
import 'package:fitness/features/exercise/domain/entities/get_all_muscles_group_entity.dart';
import 'package:fitness/features/exercise/domain/entities/get_muscles_by_group_id_entity.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';

import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepoImpl(this._homeRemoteDataSource);

  @override
  Future<Result<RandomExercisesResponseEntity>> getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  }) async {
    final response = await _homeRemoteDataSource.getRandomExercises(
      targetMuscleGroupId: targetMuscleGroupId,
      difficultyLevelId: difficultyLevelId,
      limit: limit,
    );

    switch (response) {
      case Success<RandomExercisesResponse>():
        return Success<RandomExercisesResponseEntity>(
          data: response.data.toEntity(),
        );
      case Failure<RandomExercisesResponse>():
        return Failure<RandomExercisesResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  ///? =========== Get All Muscles Group ==============
  @override
  Future<Result<List<GetAllMusclesGroupEntity>>> getAllMusclesGroup({
    required String language,
  }) async {
    final response = await _homeRemoteDataSource.getAllMusclesGroup(
      language: language,
    );

    switch (response) {
      case Success<GetAllMusclesGroupResponse>(data: final data):
        return Success(
          data: data.musclesGroup?.map((e) => e.toEntity()).toList() ?? [],
        );

      case Failure<GetAllMusclesGroupResponse>(
        errorMessage: final errorMessage,
      ):
        return Failure(errorMessage: errorMessage);
    }
  }

  ///? ================= Get Muscle Using id ===================
  @override
  Future<Result<List<GetMusclesByGroupIdEntity>>> getMusclesByGroupId({
    required String language,
    required String muscleGroupId,
  }) async {
    final response = await _homeRemoteDataSource.getMuscleGroupId(
      language: language,
      muscleGroupId: muscleGroupId,
    );
    switch (response) {
      case Success<GetMusclesGroupIdResponse>():
        return Success(
          data: response.data.muscles?.map((e) => e.toEntity()).toList() ?? [],
        );
      case Failure<GetMusclesGroupIdResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
