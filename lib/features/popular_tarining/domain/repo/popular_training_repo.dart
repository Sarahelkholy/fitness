import '../../../../config/error_handling/result.dart';

abstract class PopularTrainingRepo {
  Future<Result<List<String>>> getRandomPrimeMoverMuscles();
}
