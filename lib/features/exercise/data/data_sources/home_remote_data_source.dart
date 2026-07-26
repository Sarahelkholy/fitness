import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';

import '../../../../config/error_handling/result.dart';

import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';

import '../models/difficulty_level_response.dart';
import '../models/exercise_response.dart';

abstract interface class HomeRemoteDataSource {
  Future<Result<RandomExercisesResponse>> getRandomExercises();

  Future<ExerciseResponse> getExercises({
    String? primeMoverMuscleId,
    String? difficultyLevelId,
    int? page,
  });
  Future<DifficultyLevelResponse> getDifficultyLevels({
    String? primeMoverMuscleId,
  });

  Future<Result<GetAllMusclesGroupResponse>> getAllMusclesGroup({
    required String language,
  });

  ///? ================= Get Muscle Using id ===================
  Future<Result<GetMusclesGroupIdResponse>> getMuscleGroupId({
    required String language,
    required String muscleGroupId,
  });
}
