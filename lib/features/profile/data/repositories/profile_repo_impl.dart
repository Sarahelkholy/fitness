import 'dart:io';

import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:fitness/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:fitness/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/cache/secure_cache/secure_cache_helper.dart';
import '../../../../config/secure_cache/secure_cache/cache_keys.dart';
import '../../domain/entities/change_password_request_entity.dart';
import '../mapper/change_password_response_mapper.dart';
import '../models/response/change_password_response.dart';

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

  ///?=============== Change password =================
  @override
  Future<Result<ChangePasswordEntity>> changePassword({
    required String password,
    required String newPassword,
  }) async {
    final response = await _remoteDataSource.changePassword(
      password: password,
      newPassword: newPassword,
    );
    switch (response) {
      case Success<ChangePasswordResponse>():
        final entity = response.data.toEntity();
        if (entity.token != null && entity.token!.isNotEmpty) {
          await SecureCacheHelper.saveData(
            key: CacheKeys.token,
            value: entity.token!,
          );
        }

        return Success(data: entity);

      case Failure<ChangePasswordResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
