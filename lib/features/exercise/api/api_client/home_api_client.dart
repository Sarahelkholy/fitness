import 'package:dio/dio.dart';
import 'package:fitness/features/exercise/data/module/response/get_all_muscles_group_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/values/api_end_points.dart';
import '../../data/module/response/get_muscles_group_id_response.dart';
part 'home_api_client.g.dart';

// @injectable
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  ///? ============= Get All Muscles Group =================
  @POST(ApiEndPoints.getAllMusclesGroup)
  Future<GetAllMusclesGroupResponse> getAllMusclesGroup(
    @Header('accept-language') String language,
  );

  ///? ================= Get Muscle Using id ===================
  @POST(ApiEndPoints.getMuscleGroupId)
  Future<GetMusclesGroupIdResponse> getMuscleGroupId(
    @Header('accept-language') String language,
    @Query('muscleGroupId') String muscleGroupId,
  );
}
