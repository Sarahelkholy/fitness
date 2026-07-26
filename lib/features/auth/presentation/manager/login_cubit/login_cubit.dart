import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/config/social_auth/social_user.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';
import 'package:fitness/core/utils/app_constants.dart';
import 'package:fitness/features/auth/domain/use_cases/get_facebook_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/get_google_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/login_use_case.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/di/di.dart';
import '../../../../../config/user/manager/user_cubit.dart';
import '../../../../../config/user/manager/user_events.dart';
import '../../../data/models/requests/login_request.dart';
import 'login_event.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState, BaseEvent> {
  LoginCubit(
    this._getGoogleUserDataUseCase,
    this._loginUseCase,
    this._getFacebookUserDataUseCase,
  ) : super(LoginState());

  final LoginUseCase _loginUseCase;
  final GetGoogleUserDataUseCase _getGoogleUserDataUseCase;
  final GetFacebookUserDataUseCase _getFacebookUserDataUseCase;

  void doIntent(LoginEvent event) {
    switch (event) {
      case LoginWithApi():
        _loginWithApi(event.request);
      case LoginWithGoogle():
        _loginWithGoogle();
      case LoginWithFacebook():
        _loginWithFacebook();
    }
  }

  Future<void> _loginWithApi(LoginRequest request) async {
    emit(state.copyWith(loginWithApi: const BaseState(isLoading: true)));
    final result = await _loginUseCase(request);
    switch (result) {
      case Success<UserEntity>():
        emit(
          state.copyWith(
            loginWithApi: BaseState(data: result.data, isSuccess: true),
          ),
        );
        getIt<UserCubit>().doEvent(SetUserDataEvent(user: result.data));

        emitEvent(
          const NavigationEvent(
            routeName: Routes.bottomNavBarRoute,
            type: NavigationType.pushReplacementAndRemoveUntil,
          ),
        );
      case Failure<UserEntity>():
        emit(
          state.copyWith(
            loginWithApi: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  Future<void> _loginWithGoogle() async {
    emit(state.copyWith(loginWithGoogle: const BaseState(isLoading: true)));
    final result = await _getGoogleUserDataUseCase();
    switch (result) {
      case Success<SocialUser>():
        final loginResult = await _loginUseCase(
          LoginRequest(
            email: result.data.email ?? "",
            password: AppConstants.getSocialPassword(
              result.data.id,
            ), // where is the social ,
          ),
        );
        switch (loginResult) {
          case Success<UserEntity>():
            emit(
              state.copyWith(
                loginWithGoogle: BaseState(
                  data: loginResult.data,
                  isSuccess: true,
                ),
              ),
            );

            getIt<UserCubit>().doEvent(
              SetUserDataEvent(user: loginResult.data),
            );
            emitEvent(
              const NavigationEvent(
                routeName: Routes.bottomNavBarRoute,
                type: NavigationType.pushReplacementAndRemoveUntil,
              ),
            );
          case Failure<UserEntity>():
            emit(
              state.copyWith(
                loginWithGoogle: BaseState(
                  errorMessage: loginResult.errorMessage,
                ),
              ),
            );
            emitEvent(DisplayErrorEvent(errorMsg: loginResult.errorMessage));
        }
      case Failure<SocialUser>():
        emit(
          state.copyWith(
            loginWithGoogle: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  Future<void> _loginWithFacebook() async {
    emit(state.copyWith(loginWithFacebook: const BaseState(isLoading: true)));
    final result = await _getFacebookUserDataUseCase();
    switch (result) {
      case Success<SocialUser>():
        final loginResult = await _loginUseCase(
          LoginRequest(
            email: result.data.email ?? "",
            password: AppConstants.getSocialPassword(result.data.id),
          ),
        );
        switch (loginResult) {
          case Success<UserEntity>():
            emit(
              state.copyWith(
                loginWithFacebook: BaseState(
                  data: loginResult.data,
                  isSuccess: true,
                ),
              ),
            );
            getIt<UserCubit>().doEvent(
              SetUserDataEvent(user: loginResult.data),
            );
            emitEvent(
              const NavigationEvent(
                routeName: Routes.bottomNavBarRoute,
                type: NavigationType.pushReplacementAndRemoveUntil,
              ),
            );
          case Failure<UserEntity>():
            emit(
              state.copyWith(
                loginWithFacebook: BaseState(
                  errorMessage: loginResult.errorMessage,
                ),
              ),
            );
            emitEvent(DisplayErrorEvent(errorMsg: loginResult.errorMessage));
        }
      case Failure<SocialUser>():
        emit(
          state.copyWith(
            loginWithFacebook: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }
}
