import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:fitness/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:fitness/features/profile/domain/usecases/upload_photo_usecase.dart';
part 'edit_profile_intent.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Cubit<EditProfileState> {
  final EditProfileUsecase _editProfileUsecase;
  final UploadPhotoUsecase _uploadPhotoUsecase;

  EditProfileBloc(this._editProfileUsecase, this._uploadPhotoUsecase)
    : super(const EditProfileState());

  void handleIntents(EditProfileIntent intent) {
    switch (intent) {
      case OnEditProfilePressed():
        _EditProfile(intent);

      case OnUploadPhotoPressed():
        _UploadPhoto(intent);
        throw UnimplementedError();
    }
  }

  Future<void> _EditProfile(OnEditProfilePressed intent) async {
    emit(state.copyWith(editProfileState: const BaseState(isLoading: true)));

    final Result<EditProfileResponse> result = await _editProfileUsecase(
      intent.request,
    );

    switch (result) {
      case Success<EditProfileResponse>():
        emit(
          state.copyWith(
            editProfileState: BaseState(isSuccess: true, data: result.data),
          ),
        );
      case Failure<EditProfileResponse>():
        emit(
          state.copyWith(
            editProfileState: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  Future<void> _UploadPhoto(OnUploadPhotoPressed intent) async {
    emit(state.copyWith(uploadPhotoState: const BaseState(isLoading: true)));
    final Result<UploadPhotoResponse> result = await _uploadPhotoUsecase(
      intent.file,
    );
    switch (result) {
      case Success<UploadPhotoResponse>():
        emit(
          state.copyWith(
            uploadPhotoState: BaseState(isSuccess: true, data: result.data),
          ),
        );
      case Failure<UploadPhotoResponse>():
        emit(
          state.copyWith(
            uploadPhotoState: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }
}
