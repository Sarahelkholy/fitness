part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final BaseState<EditProfileResponse> editProfileState;
  final BaseState<UploadPhotoResponse> uploadPhotoState;
  const EditProfileState({
    this.editProfileState = const BaseState(),
    this.uploadPhotoState = const BaseState(),
  });

  EditProfileState copyWith({
    BaseState<EditProfileResponse>? editProfileState,
    BaseState<UploadPhotoResponse>? uploadPhotoState,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
    );
  }

  @override
  List<Object> get props => [editProfileState, uploadPhotoState];
}
