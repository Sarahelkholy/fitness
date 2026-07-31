import 'dart:io';

import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:fitness/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:fitness/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepoImpl(this._remoteDataSource);

  @override
  Future<Result<EditProfileResponse>> editProfile(
    EditProfileRequest request,
  ) async {
    return _remoteDataSource.editProfile(request);
  }

  @override
  Future<Result<UploadPhotoResponse>> uploadPhoto(File file) async {
    return _remoteDataSource.uploadPhoto(file);
  }
}
