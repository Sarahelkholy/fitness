import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/api/data_sources/models/response/edit_profile_response.dart';
import 'package:fitness/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUsecase {
  final ProfileRepo _repo;

  EditProfileUsecase(this._repo);

  Future<EditProfileResponse> call(EditProfileRequest request) async {
    return _repo.editProfile(request);
  }
}
