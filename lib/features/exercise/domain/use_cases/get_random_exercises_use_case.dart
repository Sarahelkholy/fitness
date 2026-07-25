import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRandomExercisesUseCase {
  final HomeRepo _homeRepo;

  GetRandomExercisesUseCase(this._homeRepo);

  Future<Result<RandomExercisesResponseEntity>> call({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  }) {
    return _homeRepo.getRandomExercises(
      targetMuscleGroupId: targetMuscleGroupId,
      difficultyLevelId: difficultyLevelId,
      limit: limit,
    );
  }
}
