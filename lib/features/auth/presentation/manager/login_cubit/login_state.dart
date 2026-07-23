import 'package:equatable/equatable.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';

import '../../../../../config/social_auth/social_user.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loginWithApi = const BaseState(),
    this.loginWithGoogle = const BaseState(),
    this.loginWithFacebook = const BaseState(),
  });

  final BaseState<UserEntity>? loginWithApi;
  final BaseState<UserEntity>? loginWithGoogle;
  final BaseState<UserEntity>? loginWithFacebook;

  @override
  List<Object?> get props => [loginWithApi, loginWithGoogle, loginWithFacebook];

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
