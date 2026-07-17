import 'dart:async';

import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/features/auth/data/models/requests/forget_password_request.dart';
import 'package:fitness/features/auth/data/models/requests/reset_password_request.dart';
import 'package:fitness/features/auth/data/models/requests/verify_reset_otp_request.dart';
import 'package:fitness/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/verify_reset_otp_use_case.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_event.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends BaseCubit<ForgetPasswordState, BaseEvent> {
  ForgetPasswordCubit(
    this._enterEmailUseCase,
    this._verifyOtpUseCase,
    this._addNewPasswordUseCase,
  ) : super(const ForgetPasswordState());

  final ForgetPasswordUseCase _enterEmailUseCase;
  final VerifyResetOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _addNewPasswordUseCase;

  Timer? _resendTimer;

  void doEvents(ForgetPasswordEvents event) {
    switch (event) {
      case SendEmailEvent():
        _enterEmail(event);

      case VerifyOtpEvent():
        _verifyOtp(event);

      case ResendOtpEvent():
        _resendOtp(event);

      case ResetPasswordEvent():
        _resetPassword(event);
    }
  }

  Future<void> _enterEmail(SendEmailEvent event) async {
    emit(
      state.copyWith(
        sendEmailStateParam: const BaseState(isLoading: true),
        emailParam: event.email,
      ),
    );

    final result = await _enterEmailUseCase.call(
      ForgetPasswordRequest(email: event.email),
    );

    switch (result) {
      case Success():
        startResendTimer();
        emit(
          state.copyWith(sendEmailStateParam: const BaseState(isSuccess: true)),
        );
        emitEvent(
          NavigationEvent(
            routeName: Routes.passwordVerifyOtpRoute,
            type: NavigationType.push,
            arguments: this,
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            sendEmailStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  Future<void> _verifyOtp(VerifyOtpEvent event) async {
    emit(state.copyWith(verifyOtpStateParam: const BaseState(isLoading: true)));

    final result = await _verifyOtpUseCase.call(
      VerifyResetOtpRequest(resetCode: event.otp),
    );

    switch (result) {
      case Success():
        emit(
          state.copyWith(verifyOtpStateParam: const BaseState(isSuccess: true)),
        );
        emitEvent(
          NavigationEvent(
            routeName: Routes.resetPasswordRoute,
            type: NavigationType.push,
            arguments: this,
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            verifyOtpStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  Future<void> _resendOtp(ResendOtpEvent event) async {
    emit(
      state.copyWith(
        sendEmailStateParam: const BaseState(isLoading: true),
        emailParam: event.email,
      ),
    );

    final result = await _enterEmailUseCase.call(
      ForgetPasswordRequest(email: event.email),
    );

    switch (result) {
      case Success():
        startResendTimer();
        emit(
          state.copyWith(sendEmailStateParam: const BaseState(isSuccess: true)),
        );

      case Failure():
        emit(
          state.copyWith(
            sendEmailStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  Future<void> _resetPassword(ResetPasswordEvent event) async {
    emit(
      state.copyWith(resetPasswordStateParam: const BaseState(isLoading: true)),
    );

    final result = await _addNewPasswordUseCase.call(
      ResetPasswordRequest(
        email: state.email ?? "",
        newPassword: event.newPassword,
      ),
    );

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            resetPasswordStateParam: const BaseState(isSuccess: true),
          ),
        );
        emitEvent(
          const DisplaySuccessEvent(
            successMsg: "Password Changed Successfully",
          ),
        );
        emitEvent(
          const NavigationEvent(
            routeName: Routes.loginRoute,
            type: NavigationType.popUntil,
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            resetPasswordStateParam: BaseState(
              errorMessage: result.errorMessage,
            ),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  void startResendTimer() {
    _resendTimer?.cancel();

    emit(state.copyWith(resendSecondsParam: 30));

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendSeconds <= 1) {
        timer.cancel();

        emit(state.copyWith(resendSecondsParam: 0));

        return;
      }

      emit(state.copyWith(resendSecondsParam: state.resendSeconds - 1));
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
