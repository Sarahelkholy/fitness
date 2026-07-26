import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRandomExercisesUseCase {
  final HomeRepo _homeRepo;

  GetRandomExercisesUseCase(this._homeRepo);

  Future<Result<RandomExercisesResponseEntity>> call() {
    return _homeRepo.getRandomExercises();
  }
}
