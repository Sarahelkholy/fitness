import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';
import 'package:fitness/features/popular_tarining/api/random_exercise_api_client.dart';
import 'package:fitness/features/popular_tarining/data/data_source/popular_training_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PopularTrainingDataSource)
class PopularTrainingDataSourceImpl implements PopularTrainingDataSource {
  PopularTrainingDataSourceImpl(this._apiClient, this._homeRemoteDataSource);

  final RandomExerciseApiClient _apiClient;
  final HomeRemoteDataSource _homeRemoteDataSource;

  @override
  Future<Result<List<String>>> getRandomPrimeMoverMuscles() async {
    try {
      final List<String> muscleIds = [];

      final groupsResult = await _homeRemoteDataSource.getAllMusclesGroup(
        language: "en",
      );

      if (groupsResult is Success<GetAllMusclesGroupResponse>) {
        final groups = groupsResult.data.musclesGroup ?? [];
        for (final group in groups) {
          if (group.id != null && group.id!.isNotEmpty) {
            final musclesByGroup =
                await _homeRemoteDataSource.getMuscleGroupId(
              language: "en",
              muscleGroupId: group.id!,
            );
            if (musclesByGroup is Success<GetMusclesGroupIdResponse>) {
              final muscles = musclesByGroup.data.muscles ?? [];
              for (final m in muscles) {
                if (m.id != null && m.id!.isNotEmpty) {
                  muscleIds.add(m.id!);
                }
              }
            }
          }
        }
      }

      if (muscleIds.isEmpty) {
        final response = await _apiClient.getRandomExercises(
          targetMuscleGroupId: "69d982ef85f6bfa972bf2248",
          difficultyLevelId: "69d982ed85f6bfa972bf2216",
          limit: 10,
        );
        final fetched = response.exercises
                ?.map((e) => e.primeMoverMuscle)
                .whereType<String>()
                .toList() ??
            [];
        muscleIds.addAll(fetched);
      }

      if (muscleIds.isEmpty) {
        muscleIds.addAll([
          "69d982ef85f6bfa972bf2248",
          "69d982ed85f6bfa972bf2218",
          "69d982ed85f6bfa972bf2219",
        ]);
      }

      return Success(data: muscleIds.toSet().toList());
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }
}
