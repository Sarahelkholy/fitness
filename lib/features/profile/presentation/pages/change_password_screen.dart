import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/base_cubit/base_event.dart';
import '../../../../core/helpers/app_snack_bar.dart';
import '../../../../core/helpers/validator.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_scaffold.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../manager/change_password_cubit/change_password_cubit.dart';
import '../manager/change_password_cubit/change_password_event.dart';
import '../manager/change_password_cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  late AppLocalizations localizations;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late final ChangePasswordCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<ChangePasswordCubit>();

    _cubit.eventStream.listen((event) {
      switch (event) {
        case DisplayErrorEvent():
          if (!mounted) return;
          AppSnackBar.error(context, event.errorMsg);

        case DisplaySuccessEvent():
          if (!mounted) return;
          AppSnackBar.success(context, event.successMsg);

        case NavigationEvent():
          if (!mounted) return;
          Navigator.pushReplacementNamed(
            context,
            event.routeName,
          );
      }
    });
  }

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      ///? ========= App Bar image =============
      appBar: AppBar(
    title: Image.asset(
    AppAssets.appLogo,
      height: 48,
      width: 70,
      fit: BoxFit.fill,
    ),
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 34),

              ///?  ======== Text Password Min Length===========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  localizations.passwordMinLength,
                  style: AppTextStyles.regular18(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(height: 6),

              ///? ======== Text Create New Password===========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  localizations.createNewPassword,
                  style: AppTextStyles.extraBold20(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 24,
                    ),
                    child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        return Column(
                          children: [

                            const SizedBox(height: 16),

                            Form(
                              key: formKey,
                              child: Column(
                                children: [

                                  ///? ========== Old password ============
                                  TextFormField(
                                    controller: oldPasswordController,
                                    obscureText: true,
                                    enabled: !state.changeOldPasswordState.isLoading,
                                    validator: Validator.password,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: localizations.currentPassword,
                                      hintText: localizations.currentPassword,
                                    ),
                                  ),
                                  const SizedBox(height: 14),

                                  ///? ===============  New password ===========
                                  TextFormField(
                                    controller: newPasswordController,
                                    obscureText: true,
                                    enabled: !state.changeOldPasswordState.isLoading,
                                    validator: Validator.password,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: localizations.newPassword,
                                      hintText: localizations.newPassword,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  TextFormField(
                                    controller: confirmNewPasswordController,
                                    obscureText: true,
                                    enabled: !state.changeOldPasswordState.isLoading,
                                    validator: (value) => Validator.confirmPassword(
                                      value,
                                      newPasswordController.text,
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: localizations.confirmNewPassword,
                                      hintText: localizations.confirmNewPassword,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  ///? Click Button
                                  CustomButton(
                                    title: localizations.done,
                                    isLoading: state.changeOldPasswordState.isLoading,
                                    onPressed: () {
                                      if (!formKey.currentState!.validate()) return;

                                      if (oldPasswordController.text.trim() ==
                                          newPasswordController.text.trim()) {
                                        AppSnackBar.error(context, localizations.oldAndNewPasswordSame);
                                        return;
                                      }

                                      _cubit.doEventChangePassword(
                                        SubmitChangePasswordEvent(
                                          password: oldPasswordController.text.trim(),
                                          newPassword: newPasswordController.text.trim(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
