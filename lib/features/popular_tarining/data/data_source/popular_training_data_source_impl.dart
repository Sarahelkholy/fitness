import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/popular_tarining/api/random_exercise_api_client.dart';
import 'package:fitness/features/popular_tarining/data/data_source/popular_training_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PopularTrainingDataSource)
class PopularTrainingDataSourceImpl implements PopularTrainingDataSource {
  PopularTrainingDataSourceImpl(this._apiClient);

  final RandomExerciseApiClient _apiClient;

  @override
  Future<Result<List<String>>> getRandomPrimeMoverMuscles() async {
    try {
      final result = await _apiClient.getRandomPrimeMoverMuscles();
      return Success(data: result);
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }
}
