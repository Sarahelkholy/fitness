import 'dart:io';

import 'package:fitness/config/error_handling/execute_api.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/profile/api/api_client/profile_api_client.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:fitness/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/request/change_password_request.dart';
import '../../data/models/response/change_password_response.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<EditProfileResponse>> editProfile(
    EditProfileRequest request,
  ) async {
    return executeApi(() async {
      return await _apiClient.editProfile(request);
    });
  }

  @override
  Future<Result<UploadPhotoResponse>> uploadPhoto(File file) async {
    return executeApi(() async {
      return await _apiClient.uploadPhoto(file);
    });
  }

  @override
  Future<Result<ChangePasswordResponse>> changePassword({
    required String password,
    required String newPassword,
  }) {
    return executeApi(() async {
      final response = await _apiClient.changePassword(
        ChangePasswordRequest(password: password, newPassword: newPassword),
      );
      return response;
    });
  }
}
