import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExercisesUseCase {
  final HomeRepo _repository;

  GetExercisesUseCase(this._repository);

  Future<Result<ExerciseInfo>> call({
    String? primeMoverMuscleId,
    String? difficultyLevelId,
    int? page,
  }) {
    return _repository.getExercises(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
  }
}
