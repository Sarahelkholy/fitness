import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/entities/get_all_muscles_group_entity.dart';
import '../entities/get_muscles_by_group_id_entity.dart';
import '../entities/difficulty_level.dart';
import '../entities/exercise_info.dart';

abstract interface class HomeRepo {
  Future<Result<RandomExercisesResponseEntity>> getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  });

  ///? =========== Get All Muscles Group ==============
  Future<Result<List<GetAllMusclesGroupEntity>>> getAllMusclesGroup({
    required String language,
  });

  ///? ================= Get Muscle Using id ===================
  Future<Result<List<GetMusclesByGroupIdEntity>>> getMusclesByGroupId({
    required String language,
    required String muscleGroupId,
  });

  Future<Result<ExerciseInfo>> getExercises({
    String? primeMoverMuscleId,
    String? difficultyLevelId,
    int? page,
  });
  Future<Result<List<DifficultyLevel>>> getDifficultyLevels({
    String? primeMoverMuscleId,
  });
}
