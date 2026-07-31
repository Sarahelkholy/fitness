import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitness/core/values/api_end_points.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(ApiEndPoints.editProfile)
  Future<EditProfileResponse> editProfile(@Body() EditProfileRequest request);

  @PUT(ApiEndPoints.uploadPhoto)
  @MultiPart()
  Future<UploadPhotoResponse> uploadPhoto(@Part() File file);
}
