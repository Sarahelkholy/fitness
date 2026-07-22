import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/module/response/get_all_muscles_group_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/execute_api.dart';
import '../../data/module/response/get_muscles_group_id_response.dart';
import '../api_client/home_api_client.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiClient _apiClient;
  HomeRemoteDataSourceImpl(this._apiClient);


  ///? ========= Get All Muscles Group ============
  @override
  Future<Result<GetAllMusclesGroupResponse>> getAllMusclesGroup({required String language}) {
    return executeApi(() async {
      return await _apiClient.getAllMusclesGroup(language);
    });
  }

  ///? ================= Get Muscle Using id ===================
  @override
  Future<Result<GetMusclesGroupIdResponse>> getMuscleGroupId({required String language, required String muscleGroupId}) async{
    return executeApi(()async{
      return await _apiClient.getMuscleGroupId(language, muscleGroupId);
    });
  }

}
