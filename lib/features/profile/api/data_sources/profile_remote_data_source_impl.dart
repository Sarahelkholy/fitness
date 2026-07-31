import 'dart:io';

import 'package:fitness/features/profile/api/api_client/profile_api_client.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:fitness/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<EditProfileResponse> editProfile(EditProfileRequest request) {
    return _apiClient.editProfile(request);
  }

  @override
  Future<UploadPhotoResponse> uploadPhoto(File file) {
    return _apiClient.uploadPhoto(file);
  }
}
