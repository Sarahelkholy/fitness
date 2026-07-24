import 'dart:async';
import 'package:fitness/core/helpers/app_snack_bar.dart';
import 'package:fitness/core/helpers/validator.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_event.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvideEmailView extends StatefulWidget {
  final Function(String) onNext;
  const ProvideEmailView({super.key, required this.onNext});

  @override
  State<ProvideEmailView> createState() => _ProvideEmailViewState();
}

class _ProvideEmailViewState extends State<ProvideEmailView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    _emailController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.sendEmailState != current.sendEmailState,
      listener: (context, state) {
        if (state.sendEmailState.isSuccess) {
          AppSnackBar.success(context, 'OTP code sent to your email.');
          widget.onNext(_emailController.text);
        } else if (state.sendEmailState.errorMessage?.isNotEmpty ?? false) {
          AppSnackBar.error(
            context,
            state.sendEmailState.errorMessage ?? 'Error',
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.current.enterEmail,
            style: AppTextStyles.regular14(
              context,
            ).copyWith(color: AppColors.white),
          ),
          SizedBox(height: mediaQuery.height * .01),
          Text(
            AppStrings.current.forgetPassword,
            style: AppTextStyles.bold24(
              context,
            ).copyWith(color: AppColors.white),
          ),
          SizedBox(height: mediaQuery.height * .02),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextStyles.medium16(
                    context,
                  ).copyWith(color: AppColors.white),

                  validator: Validator.email,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.white,
                      size: 20,
                    ),
                    hintText: AppStrings.current.email,
                    hintStyle: AppTextStyles.regular14(
                      context,
                    ).copyWith(color: AppColors.white.withValues(alpha: 0.5)),
                    filled: true,
                    fillColor: AppColors.pureBlack.withValues(alpha: 0.2),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: mediaQuery.height * .02,
                      horizontal: mediaQuery.width * .05,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: AppColors.white.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: AppColors.white.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: AppColors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mediaQuery.height * .02),
                BlocSelector<ForgetPasswordCubit, ForgetPasswordState, bool>(
                  selector: (state) => state.sendEmailState.isLoading,
                  builder: (context, isLoading) {
                    return CustomButton(
                      title: AppStrings.current.sendOtp,
                      isLoading: isLoading,
                      onPressed: () {
                        context.read<ForgetPasswordCubit>().doEvents(
                          SendEmailEvent(
                            email: _emailController.text.trim().toLowerCase(),
                          ),
                        );
                      },
                    );
                  },
                ),
                // SizedBox(height: mediaQuery.height * .01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
