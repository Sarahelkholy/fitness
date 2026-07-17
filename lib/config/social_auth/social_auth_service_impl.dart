import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../error_handling/execute_api.dart';
import '../error_handling/result.dart';
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
  Future<Result<SocialUser>> getGoogleUserData() {
    return executeApi<SocialUser>(() async {
      // Disconnect or SignOut to force account selector
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw PlatformException(code: 'sign_in_cancelled');
      }

      // Extract first and last name from display name
      String? firstName;
      String? lastName;
      if (googleUser.displayName != null) {
        final nameParts = googleUser.displayName!.trim().split(' ');
        if (nameParts.isNotEmpty) {
          firstName = nameParts.first;
          if (nameParts.length > 1) {
            lastName = nameParts.sublist(1).join(' ');
          }
        }
      }

      return SocialUser(
        id: googleUser.id,
        email: googleUser.email,
        name: googleUser.displayName,
        firstName: firstName,
        lastName: lastName,
        photo: googleUser.photoUrl,
      );
    });
  }

  @override
  Future<Result<SocialUser>> getFacebookUserData() {
    return executeApi<SocialUser>(() async {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: SocialAuthConstants.facebookPermissions,
      );

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData(
          fields: SocialAuthConstants.facebookFields,
        );

        if (userData[SocialAuthConstants.emailKey] == null) {
          throw PlatformException(code: "email_not_found");
        }

        return SocialUser(
          id: userData[SocialAuthConstants.idKey],
          email: userData[SocialAuthConstants.emailKey],
          name: userData[SocialAuthConstants.nameKey],
          firstName: userData[SocialAuthConstants.firstNameKey],
          lastName: userData[SocialAuthConstants.lastNameKey],
          photo:
              userData[SocialAuthConstants.pictureKey]?[SocialAuthConstants
                  .dataKey]?[SocialAuthConstants.urlKey],
        );
      } else if (result.status == LoginStatus.cancelled) {
        throw PlatformException(code: 'sign_in_cancelled');
      } else {
        throw PlatformException(
          code: 'facebook_login_error',
          message: result.message,
        );
      }
    });
  }
}
