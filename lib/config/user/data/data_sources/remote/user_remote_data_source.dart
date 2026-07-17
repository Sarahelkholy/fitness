import '../../../../error_handling/result.dart';
import '../../models/requests/update_user_data_request.dart';
import '../../models/responses/get_user_response/get_user_data_response.dart';

abstract interface class UserRemoteDataSource {
  Future<Result<GetUserDataResponse>> getUserData();
  Future<Result<GetUserDataResponse>> updateUserData(
    UpdateUserDataRequest request,
  );
  // Future<Result<Map<String,String>>> logout();
}
