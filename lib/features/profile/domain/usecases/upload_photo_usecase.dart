import 'dart:io';

import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:fitness/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUsecase {
  final ProfileRepo _repo;

  UploadPhotoUsecase(this._repo);

  Future<Result<UploadPhotoResponse>> call(File file) async {
    return _repo.uploadPhoto(file);
  }
}
