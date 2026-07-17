import 'package:fitness/features/auth/domain/use_cases/get_facebook_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/get_google_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/login_use_case.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../data/models/requests/login_request.dart';
import 'login_event.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
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
        // TODO: Handle this case.
        throw UnimplementedError();
      case LoginWithFacebook():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> _loginWithApi(LoginRequest request) async {
    emit(state.copyWith(loginWithApi: const BaseState(isLoading: true)));
    final result = await _loginUseCase(request);
  }
}
