import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/config/user/manager/user_events.dart';
import 'package:fitness/core/utils/app_constants.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/error_handling/result.dart';
import '../../../../../config/social_auth/social_user.dart';
import '../../../data/models/requests/register_request.dart';
import '../../../domain/use_cases/get_facebook_user_data_use_case.dart';
import '../../../domain/use_cases/get_google_user_data_use_case.dart';
import '../../../domain/use_cases/register_use_case.dart';
import 'register_event.dart';
import 'register_state.dart';

@injectable
class RegisterCubit extends BaseCubit<RegisterState, BaseEvent> {
  final RegisterUseCase _registerUseCase;
  final GetGoogleUserDataUseCase _getGoogleUserDataUseCase;
  final GetFacebookUserDataUseCase _getFacebookUserDataUseCase;

  RegisterCubit(
    this._registerUseCase,
    this._getGoogleUserDataUseCase,
    this._getFacebookUserDataUseCase,
  ) : super(const RegisterState());

  void doEvents(RegisterEvents event) {
    switch (event) {
      case SubmitRegisterEvent():
        _submitRegister(event);
      case GoogleRegisterEvent():
        _googleRegister();
      case FacebookRegisterEvent():
        _facebookRegister();
      case SubmitPressedEvent():
        emit(state.copyWith(isSubmittedParam: true));
    }
  }

  Future<void> _submitRegister(SubmitRegisterEvent event) async {
    emit(state.copyWith(registerStateParam: const BaseState(isLoading: true)));

    final request = RegisterRequest(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      rePassword: event.password,
      gender: "male",
      height: 175,
      weight: 75,
      age: 25,
      goal: "Lose Weight",
      activityLevel: "level1",
    );

    final result = await _registerUseCase.call(request);

    _handleResult(result);
  }

  Future<void> _googleRegister() async {
    emit(state.copyWith(registerStateParam: const BaseState(isLoading: true)));

    final result = await _getGoogleUserDataUseCase.call();
    _handleSocialResult(result);
  }

  Future<void> _facebookRegister() async {
    emit(state.copyWith(registerStateParam: const BaseState(isLoading: true)));

    final result = await _getFacebookUserDataUseCase.call();
    _handleSocialResult(result);
  }

  Future<void> _handleSocialResult(Result<SocialUser> result) async {
    switch (result) {
      case Success():
        final request = RegisterRequest(
          firstName: result.data.firstName ?? "user",
          lastName: result.data.lastName ?? "name",
          email: result.data.email!,
          password: AppConstants.getSocialPassword(result.data.id),
          rePassword: AppConstants.getSocialPassword(result.data.id),
          gender: "male",
          height: 175,
          weight: 75,
          age: 25,
          goal: "Lose Weight",
          activityLevel: "level1",
        );

        final callingApi = await _registerUseCase.call(request);

        _handleResult(callingApi);
      case Failure():
        emit(
          state.copyWith(
            registerStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  void _handleResult(Result result) {
    switch (result) {
      case Success():
        emit(
          state.copyWith(
            registerStateParam: BaseState(isSuccess: true, data: result.data),
          ),
        );
        getIt<UserCubit>().doEvent(SetUserDataEvent(user: result.data));
        emitEvent(
          const NavigationEvent(
            routeName: Routes.registerFormRoute,
            type: NavigationType.pushReplacementAndRemoveUntil,
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            registerStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }
}
