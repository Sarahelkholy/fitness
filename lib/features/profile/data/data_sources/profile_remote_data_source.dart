import 'dart:io';

import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';

abstract interface class ProfileRemoteDataSource {
  Future<EditProfileResponse> editProfile(EditProfileRequest request);
  Future<UploadPhotoResponse> uploadPhoto(File file);
}
