import '../../../../config/error_handling/result.dart';

abstract class PopularTrainingDataSource {
  Future<Result<List<String>>> getRandomPrimeMoverMuscles();
}
