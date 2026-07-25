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
      final response = await _apiClient.getRandomExercises(
        targetMuscleGroupId:
            "69d982ef85f6bfa972bf2248", // Default muscle group (Abdominals)
        difficultyLevelId:
            "69d982ed85f6bfa972bf2216", // Default level (Beginner)
        limit: 10,
      );
      final List<String> muscleIds =
          response.exercises
              ?.map((e) => e.primeMoverMuscle)
              .whereType<String>()
              .toSet()
              .toList() ??
          [];

      // Fallback: If the API returns no exercises for the default group, use known valid muscle IDs
      // so the downstream cubit can retrieve difficulty levels and exercises successfully.
      if (muscleIds.isEmpty) {
        muscleIds.addAll([
          "69d982ef85f6bfa972bf2248", // Abdominals / Rectus Abdominis
        ]);
      }

      return Success(data: muscleIds);
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }
}
