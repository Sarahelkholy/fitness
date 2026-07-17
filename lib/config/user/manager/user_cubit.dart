import 'package:fitness/config/user/manager/user_events.dart';
import 'package:fitness/config/user/manager/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/result.dart';
import '../domain/use_cases/get_user_data_use_case.dart';

@lazySingleton
@lazySingleton
class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase _getUserDataUseCase;

  UserCubit(this._getUserDataUseCase) : super(UserState());

  bool _handledUnauthorized = false;

  void doEvent(UserEvents event) {
    switch (event) {
      case GetUserDataEvent():
        _getUserData();
        break;

      case SetUserDataEvent():
        emit(state.copyWith(user: event.user));
        break;

      case UnauthorizedUserEvent():
        _handleUnauthorized();
        break;

      case ResetUnauthorizedEvent():
        _resetUnauthorized();
        break;
    }
  }

  Future<void> _getUserData() async {
    emit(state.copyWith(isLoading: true));

    final response = await _getUserDataUseCase.call();

    switch (response) {
      case Success():
        final user = response.data;

        emit(state.copyWith(isLoading: false, user: user));
        break;

      case Failure():
        emit(state.copyWith(isLoading: false, error: response.errorMessage));
        break;
    }
  }

  void _resetUnauthorized() {
    _handledUnauthorized = false;
    emit(state.copyWith(isUnauthorized: false));
  }

  void _handleUnauthorized() {
    if (_handledUnauthorized) return;

    _handledUnauthorized = true;

    emit(state.copyWith(isUnauthorized: true, user: null));
  }
}
