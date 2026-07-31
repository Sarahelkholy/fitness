import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/upload_photo_response.dart';
import 'package:fitness/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:fitness/features/profile/domain/usecases/upload_photo_usecase.dart';
import 'package:fitness/config/user/data/models/requests/update_user_data_request.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';
import 'package:fitness/config/user/domain/use_cases/update_user_data_use_case.dart';
part 'edit_profile_intent.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUsecase _editProfileUsecase;
  final UploadPhotoUsecase _uploadPhotoUsecase;
  final UpdateUserDataUseCase _updateUserDataUseCase;

  EditProfileCubit(
    this._editProfileUsecase,
    this._uploadPhotoUsecase,
    this._updateUserDataUseCase,
  ) : super(const EditProfileState());

  void doIntents(EditProfileIntent intent) {
    switch (intent) {
      case OnEditProfilePressed():
        _editProfile(intent);

      case OnUploadPhotoPressed():
        _uploadPhoto(intent);

      case OnUpdateUserDataPressed():
        _updateUserData(intent);
    }
  }

  Future<void> _editProfile(OnEditProfilePressed intent) async {
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

  Future<void> _uploadPhoto(OnUploadPhotoPressed intent) async {
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

  Future<void> _updateUserData(OnUpdateUserDataPressed intent) async {
    emit(state.copyWith(updateUserDataState: const BaseState(isLoading: true)));
    final Result<UserEntity> result = await _updateUserDataUseCase(
      intent.request,
    );
    switch (result) {
      case Success<UserEntity>():
        emit(
          state.copyWith(
            updateUserDataState: BaseState(isSuccess: true, data: result.data),
          ),
        );
      case Failure<UserEntity>():
        emit(
          state.copyWith(
            updateUserDataState: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }
}
