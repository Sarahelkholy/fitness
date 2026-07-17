import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';

import '../../../../../config/social_auth/social_user.dart';

class LoginState {
  LoginState({
    this.loginWithApi = const BaseState(),
    this.loginWithGoogle,
    this.loginWithFacebook,
  });

  BaseState<UserEntity>? loginWithApi = const BaseState();
  BaseState<SocialUser>? loginWithGoogle = const BaseState();
  BaseState<SocialUser>? loginWithFacebook = const BaseState();

  LoginState copyWith({
    BaseState<UserEntity>? loginWithApi,
    BaseState<SocialUser>? loginWithGoogle,
    BaseState<SocialUser>? loginWithFacebook,
  }) {
    return LoginState(
      loginWithApi: loginWithApi ?? this.loginWithApi,
      loginWithGoogle: loginWithGoogle ?? this.loginWithGoogle,
      loginWithFacebook: loginWithFacebook ?? this.loginWithFacebook,
    );
  }
}
