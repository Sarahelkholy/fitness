import 'dart:async';

import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/core/helpers/app_snack_bar.dart';
import 'package:fitness/core/helpers/validator.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_event.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  StreamSubscription? _streamSubscription;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _streamSubscription = context
          .read<ForgetPasswordCubit>()
          .eventStream
          .listen((event) {
            if (!mounted) return;
            switch (event) {
              case DisplayErrorEvent():
                AppSnackBar.error(context, event.errorMsg);
              case DisplaySuccessEvent():
                AppSnackBar.success(context, event.successMsg);
                Navigator.of(context).pop();
              case NavigationEvent():
                Navigator.of(context).pop();
              default:
                break;
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.current.makeSureIts8Chars,
          style: AppTextStyles.semiBold18(context),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.current.createNewPassword,
          style: AppTextStyles.bold24(context),
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: AppTextStyles.medium18(context),
                validator: Validator.password,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                  hintText: AppStrings.current.newPassword,
                  hintStyle: AppTextStyles.regular16(context),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                style: AppTextStyles.medium18(context),
                validator: (value) => Validator.confirmPassword(
                  value,
                  _passwordController.text,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                  hintText: AppStrings.current.confirmNewPasswordHint,
                  hintStyle: AppTextStyles.regular16(context),
                ),
              ),
              const SizedBox(height: 20),
              BlocSelector<ForgetPasswordCubit, ForgetPasswordState, bool>(
                selector: (state) => state.resetPasswordState.isLoading,
                builder: (context, isLoading) {
                  return CustomButton(
                    title: AppStrings.current.done,
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ForgetPasswordCubit>().doEvents(
                          ResetPasswordEvent(
                            email: context
                                .read<ForgetPasswordCubit>()
                                .state
                                .email ?? '',
                            newPassword: _passwordController.text,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}
