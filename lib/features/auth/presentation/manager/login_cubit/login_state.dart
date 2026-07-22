import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';

class LoginState {
  LoginState({this.loginWithApi, this.loginWithGoogle, this.loginWithFacebook});

  BaseState<UserEntity>? loginWithApi = const BaseState();
  BaseState<UserEntity>? loginWithGoogle = const BaseState();
  BaseState<UserEntity>? loginWithFacebook = const BaseState();

  LoginState copyWith({
    BaseState<UserEntity>? loginWithApi,
    BaseState<UserEntity>? loginWithGoogle,
    BaseState<UserEntity>? loginWithFacebook,
  }) {
    return LoginState(
      loginWithApi: loginWithApi ?? this.loginWithApi,
      loginWithGoogle: loginWithGoogle ?? this.loginWithGoogle,
      loginWithFacebook: loginWithFacebook ?? this.loginWithFacebook,
    );
  }
}
