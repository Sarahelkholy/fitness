part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final BaseState<EditProfileResponse> editProfileState;
  final BaseState<UploadPhotoResponse> uploadPhotoState;
  final BaseState<UserEntity> updateUserDataState;

  const EditProfileState({
    this.editProfileState = const BaseState(),
    this.uploadPhotoState = const BaseState(),
    this.updateUserDataState = const BaseState(),
  });

  EditProfileState copyWith({
    BaseState<EditProfileResponse>? editProfileState,
    BaseState<UploadPhotoResponse>? uploadPhotoState,
    BaseState<UserEntity>? updateUserDataState,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
      updateUserDataState: updateUserDataState ?? this.updateUserDataState,
    );
  }

  @override
  List<Object> get props => [
    editProfileState,
    uploadPhotoState,
    updateUserDataState,
  ];
}
