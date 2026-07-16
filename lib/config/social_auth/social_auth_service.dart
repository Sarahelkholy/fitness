import 'social_user.dart';

abstract class SocialAuthService {
  Future<SocialUser?> getGoogleUserData();
  Future<SocialUser?> getFacebookUserData();
}
