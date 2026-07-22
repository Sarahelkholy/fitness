import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/mappers/home/random_exercises_response_mapper.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _homeDataSource;

  HomeRepoImpl(this._homeDataSource);

  @override
  Future<Result<RandomExercisesResponseEntity>> getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  }) async {
    final response = await _homeDataSource.getRandomExercises(
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
}
