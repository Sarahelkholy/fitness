import 'dart:async';

import 'package:fitness/core/helpers/app_snack_bar.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_event.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_state.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeView extends StatefulWidget {
  final String email;
  final VoidCallback onNext;
  const VerifyCodeView({super.key, required this.email, required this.onNext});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final TextEditingController _otpController = TextEditingController();
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    _otpController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.verifyOtpState != current.verifyOtpState,
      listener: (context, state) {
        if (state.verifyOtpState.isSuccess) {
          AppSnackBar.success(context, 'OTP code verified successfully');
          widget.onNext();
        } else if (state.verifyOtpState.errorMessage?.isNotEmpty ?? false) {
          AppSnackBar.error(context, state.verifyOtpState.errorMessage!);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.current.otpCode,
            style: AppTextStyles.bold24(
              context,
            ).copyWith(color: AppColors.white),
          ),
          Text(
            AppStrings.current.otpCodeDescription,
            style: AppTextStyles.regular16(
              context,
            ).copyWith(color: AppColors.white),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PinCodeTextField(
                appContext: context,
                controller: _otpController,
                length: 4,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                textStyle: AppTextStyles.medium18(
                  context,
                ).copyWith(color: AppColors.main),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeColor: AppColors.main,
                  inactiveColor: AppColors.white.withValues(alpha: 0.5),
                  selectedColor: AppColors.main,
                  activeFillColor: AppColors.transparent,
                  inactiveFillColor: AppColors.transparent,
                  selectedFillColor: AppColors.transparent,
                ),
                cursorColor: AppColors.main,
              ),
              SizedBox(height: mediaQuery.height * .02),
              BlocSelector<ForgetPasswordCubit, ForgetPasswordState, bool>(
                selector: (state) => state.verifyOtpState.isLoading,
                builder: (context, isLoading) {
                  return CustomButton(
                    title: AppStrings.current.confirm,
                    isLoading: isLoading,
                    onPressed: () {
                      context.read<ForgetPasswordCubit>().doEvents(
                        VerifyOtpEvent(otp: _otpController.text),
                      );
                    },
                  );
                },
              ),
              Center(
                child: Text(
                  AppStrings.current.didntReceiveCode,
                  style: AppTextStyles.regular14(
                    context,
                  ).copyWith(color: AppColors.white.withValues(alpha: 0.7)),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<ForgetPasswordCubit>().doEvents(
                      ResendOtpEvent(email: widget.email),
                    );
                  },
                  child: Text(
                    AppStrings.current.resendCode,
                    style: AppTextStyles.bold14(context).copyWith(
                      color: AppColors.main,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.main,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
