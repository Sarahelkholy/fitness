import 'package:fitness/features/exercise/data/module/response/get_all_muscles_group_response.dart';
import '../../../../config/error_handling/result.dart';
import '../module/response/get_muscles_group_id_response.dart';

abstract interface class HomeRemoteDataSource {

  ///? ========= Get All Muscles Group ============
  Future<Result<GetAllMusclesGroupResponse>> getAllMusclesGroup({required String language });

  ///? ================= Get Muscle Using id ===================
  Future<Result<GetMusclesGroupIdResponse>> getMuscleGroupId({required String language, required String muscleGroupId});
}
