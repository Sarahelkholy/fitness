import 'package:fitness/features/profile/api/api_client/profile_api_client.dart';
import 'package:fitness/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/execute_api.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/request/change_password_request.dart';
import '../../data/models/response/change_password_response.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  ///?  ================== Change password =========
  @override
  Future<Result<ChangePasswordResponse>> changePassword({
    required String password,
    required String newPassword,
  }) {
    return executeApi(() async {
      final response = await _apiClient.changePassword(
        ChangePasswordRequest(
          password: password,
          newPassword: newPassword,
        ),
      );
      return response;
    });
  }
}
