import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../config/social_auth/social_user.dart';
import '../repositories/auth_repo.dart';

@injectable
class GetFacebookUserDataUseCase {
  final AuthRepo _repo;

  const GetFacebookUserDataUseCase(this._repo);

  Future<Result<SocialUser>> call() {
    return _repo.getFacebookUserData();
  }
}
