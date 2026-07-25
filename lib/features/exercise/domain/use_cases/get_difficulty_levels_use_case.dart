import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDifficultyLevelsUseCase {
  final HomeRepo _repository;

  GetDifficultyLevelsUseCase(this._repository);

  Future<Result<List<DifficultyLevel>>> call({
    String? primeMoverMuscleId,
  }) {
    return _repository.getDifficultyLevels(
      primeMoverMuscleId: primeMoverMuscleId,
    );
  }
}
