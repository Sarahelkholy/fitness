import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../core/helpers/custom_logger.dart';
import 'social_auth_constants.dart';
import 'social_auth_service.dart';
import 'social_user.dart';

@LazySingleton(as: SocialAuthService)
class SocialAuthServiceImpl implements SocialAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      SocialAuthConstants.googleEmailScope,
      SocialAuthConstants.googleProfileScope,
    ],
  );

  @override
  Future<SocialUser?> getGoogleUserData() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      return SocialUser(
        id: googleUser.id,
        email: googleUser.email,
        name: googleUser.displayName,
        photo: googleUser.photoUrl,
      );
    } catch (e, s) {
      CustomLogger.bgRed(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  Future<SocialUser?> getFacebookUserData() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: SocialAuthConstants.facebookPermissions,
      );

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData(
          fields: SocialAuthConstants.facebookFields,
        );

        return SocialUser(
          id: userData[SocialAuthConstants.idKey],
          email: userData[SocialAuthConstants.emailKey],
          name: userData[SocialAuthConstants.nameKey],
          firstName: userData[SocialAuthConstants.firstNameKey],
          lastName: userData[SocialAuthConstants.lastNameKey],
          photo: userData[SocialAuthConstants.pictureKey]
              ?[SocialAuthConstants.dataKey]?[SocialAuthConstants.urlKey],
        );
      }
      return null;
    } catch (e, s) {
      CustomLogger.bgRed(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
