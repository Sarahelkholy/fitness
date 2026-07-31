part of 'edit_profile_cubit.dart';

sealed class EditProfileIntent extends Equatable {
  const EditProfileIntent();

  @override
  List<Object> get props => [];
}

class OnEditProfilePressed extends EditProfileIntent {
  final EditProfileRequest request;

  const OnEditProfilePressed(this.request);

  @override
  List<Object> get props => [request];
}

class OnUploadPhotoPressed extends EditProfileIntent {
  final File file;

  const OnUploadPhotoPressed(this.file);

  @override
  List<Object> get props => [file];
}

class OnUpdateUserDataPressed extends EditProfileIntent {
  final UpdateUserDataRequest request;

  const OnUpdateUserDataPressed(this.request);

  @override
  List<Object> get props => [request];
}
