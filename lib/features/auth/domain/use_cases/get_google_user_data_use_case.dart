import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../config/social_auth/social_user.dart';
import '../repositories/auth_repo.dart';

@injectable
class GetGoogleUserDataUseCase {
  final AuthRepo _repo;

  const GetGoogleUserDataUseCase(this._repo);

  Future<Result<SocialUser>> call() {
    return _repo.getGoogleUserData();
  }
}
