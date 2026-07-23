import 'dart:ui';

import 'package:fitness/core/helpers/event_handler_mixin.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/data/models/requests/login_request.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_event.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:fitness/features/auth/presentation/widgets/login/dont_have_an_account_widget.dart';
import 'package:fitness/features/auth/presentation/widgets/register/or_divider.dart';
import 'package:fitness/features/auth/presentation/widgets/register/social_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../../config/route_manager/routes.dart';
import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with EventHandlerMixin {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late KeyboardVisibilityController keyboardVisibilityController;

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  late AppLocalizations localizations;
  late final LoginCubit _cubit;

  bool isPasswordHidden = true;

  @override
  void initState() {
    keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((visible) {
      if (!visible) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });

    _cubit = context.read<LoginCubit>();

    _cubit.eventStream.listen((event) {
      if (!mounted) return;

      handleEvent(event);
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  localizations.heyThere,
                  style: AppTextStyles.regular18(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  localizations.welcomeBack,
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
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Text(
                              localizations.login,
                              style: AppTextStyles.extraBold24(
                                context,
                              ).copyWith(color: AppColors.white),
                            ),
                            const SizedBox(height: 16),

                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  /// Email Field
                                  TextFormField(
                                    controller: emailController,
                                    enabled: true,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                    ),
                                    validator: Validator.email,
                                    keyboardType: TextInputType.emailAddress,
                                    focusNode: emailFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(passwordFocus);
                                    },
                                    onTapOutside: (event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    decoration: InputDecoration(
                                      labelText: localizations.email,
                                      labelStyle: const TextStyle(
                                        color: AppColors.white,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  /// Password Field
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: isPasswordHidden,
                                    enabled: true,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                    ),
                                    validator: Validator.password,
                                    keyboardType: TextInputType.visiblePassword,
                                    focusNode: passwordFocus,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    onTapOutside: (event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    decoration: InputDecoration(
                                      labelText: localizations.password,
                                      labelStyle: const TextStyle(
                                        color: AppColors.white,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: AppColors.white,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isPasswordHidden
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: AppColors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordHidden =
                                                !isPasswordHidden;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  const OrDivider(),
                                  const SizedBox(height: 24),
                                  SocialRowWidget(
                                    facebookOnTap: () {
                                      _cubit.doIntent(LoginWithFacebook());
                                    },
                                    googleOnTap: () {
                                      _cubit.doIntent(LoginWithGoogle());
                                    },
                                    appleOnTap: () {},
                                    isLoading:
                                        (state.loginWithGoogle?.isLoading ??
                                            false) ||
                                        (state.loginWithFacebook?.isLoading ??
                                            false),
                                  ),
                                  const SizedBox(height: 24),
                                  CustomButton(
                                    title: localizations.login,
                                    foregroundColor: AppColors.white,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        _cubit.doIntent(
                                          LoginWithApi(
                                            LoginRequest(
                                              email: emailController.text
                                                  .trim(),
                                              password: passwordController.text,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    isLoading:
                                        state.loginWithApi?.isLoading ?? false,
                                  ),
                                  const SizedBox(height: 8),
                                  DontHaveAnAccountWidget(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        Routes.registerRoute,
                                      );
                                    },
                                    title: localizations.doNotHaveAnAccount,
                                    actionText: localizations.register,
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
