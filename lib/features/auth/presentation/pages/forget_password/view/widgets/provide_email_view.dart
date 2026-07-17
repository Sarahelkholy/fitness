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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _streamSubscription = context
          .read<ForgetPasswordCubit>()
          .eventStream
          .listen((event) {
            switch (event) {
              case DisplayErrorEvent():
                AppSnackBar.error(context, event.errorMsg);
              case NavigationEvent():
                widget.onNext(_emailController.text);
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
          AppStrings.current.enterEmail,
          style: AppTextStyles.regular18(context),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.current.forgetPassword,
          style: AppTextStyles.bold24(context),
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTextStyles.medium18(context),
                validator: Validator.email,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: AppStrings.current.email,
                  hintStyle: AppTextStyles.regular16(context),
                ),
              ),
              const SizedBox(height: 20),
              BlocSelector<ForgetPasswordCubit, ForgetPasswordState, bool>(
                selector: (state) => state.sendEmailState.isLoading,
                builder: (context, isLoading) {
                  return CustomButton(
                    title: AppStrings.current.login,
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ForgetPasswordCubit>().doEvents(
                          SendEmailEvent(
                            email: _emailController.text.toLowerCase(),
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
