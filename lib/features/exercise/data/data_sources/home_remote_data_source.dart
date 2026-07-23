import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';

import '../../../../config/error_handling/result.dart';

import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';

abstract interface class HomeRemoteDataSource {
  Future<Result<RandomExercisesResponse>> getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  });

  ///? ========= Get All Muscles Group ============
  Future<Result<GetAllMusclesGroupResponse>> getAllMusclesGroup({
    required String language,
  });

  ///? ================= Get Muscle Using id ===================
  Future<Result<GetMusclesGroupIdResponse>> getMuscleGroupId({
    required String language,
    required String muscleGroupId,
  });
}
