import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/popular_tarining/domain/repo/popular_training_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRandomExerciseUseCase {
  final PopularTrainingRepo _popularTrainingRepo;

  GetRandomExerciseUseCase(this._popularTrainingRepo);

  Future<Result<List<String>>> getRandomPrimeMoverMuscles() async {
    return await _popularTrainingRepo.getRandomPrimeMoverMuscles();
  }
}
