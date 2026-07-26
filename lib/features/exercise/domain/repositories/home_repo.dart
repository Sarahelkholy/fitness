import 'package:fitness/features/exercise/domain/entities/get_all_muscles_group_entity.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/get_muscles_by_group_id_entity.dart';

abstract interface class HomeRepo {

  ///? =========== Get All Muscles Group ==============
  Future<Result<List<GetAllMusclesGroupEntity>>> getAllMusclesGroup({
    required String language,
  });

  ///? ================= Get Muscle Using id ===================
  Future<Result<List<GetMusclesByGroupIdEntity>>> getMusclesByGroupId({
    required String language,
    required String muscleGroupId,
  });

}
