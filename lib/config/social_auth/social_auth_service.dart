import '../error_handling/result.dart';
import 'social_user.dart';

abstract class SocialAuthService {
  Future<Result<SocialUser>> getGoogleUserData();
  Future<Result<SocialUser>> getFacebookUserData();
}
