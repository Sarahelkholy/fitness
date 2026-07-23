import 'dart:async';

import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/helpers/app_snack_bar.dart';
import 'package:fitness/core/helpers/validator.dart';
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
          style: AppTextStyles.regular14(
            context,
          ).copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.current.createNewPassword,
          style: AppTextStyles.bold24(context).copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 24),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 24,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: AppTextStyles.medium16(
                  context,
                ).copyWith(color: AppColors.white),
                validator: Validator.password,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.white,
                    size: 20,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                  hintText: AppStrings.current.password,
                  hintStyle: AppTextStyles.regular14(
                    context,
                  ).copyWith(color: AppColors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: AppColors.pureBlack.withOpacity(0.2),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.main, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                style: AppTextStyles.medium16(
                  context,
                ).copyWith(color: AppColors.white),
                validator: (value) =>
                    Validator.confirmPassword(value, _passwordController.text),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.white,
                    size: 20,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                  hintText: AppStrings.current.password,
                  hintStyle: AppTextStyles.regular14(
                    context,
                  ).copyWith(color: AppColors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: AppColors.pureBlack.withOpacity(0.2),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.main,
                      width: 1,
                    ),
                  ),
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
                            email:
                                context
                                    .read<ForgetPasswordCubit>()
                                    .state
                                    .email ??
                                '',
                            newPassword: _passwordController.text,
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.loginRoute,
                          (route) => false,
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
              ),
            ),
          ),
      ],
    );
  }
}
