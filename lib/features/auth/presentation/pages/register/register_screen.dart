import 'dart:ui';

import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/presentation/widgets/register/have_an_account_widget.dart';
import 'package:fitness/features/auth/presentation/widgets/register/or_divider.dart';
import 'package:fitness/features/auth/presentation/widgets/register/social_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late KeyboardVisibilityController keyboardVisibilityController;

  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  late AppLocalizations localizations;

  bool isPasswordHidden = true;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
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
                  style: AppTextStyles.regular18(context),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  localizations.createAnAccount,
                  style: AppTextStyles.extraBold20(context),
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
                    child: Column(
                      children: [
                        Text(
                          localizations.register,
                          style: AppTextStyles.extraBold24(context),
                        ),
                        const SizedBox(height: 16),

                        Form(
                          child: Column(
                            children: [
                              /// first name Field
                              TextFormField(
                                controller: firstNameController,
                                enabled: true,
                                validator: Validator.name,
                                keyboardType: TextInputType.name,
                                focusNode: firstNameFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(lastNameFocus);
                                },
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                  labelText: localizations.firstName,
                                  prefixIcon: const Icon(Icons.person_outline),
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// lastname Field
                              TextFormField(
                                controller: lastNameController,
                                enabled: true,
                                validator: Validator.name,
                                keyboardType: TextInputType.name,
                                focusNode: lastNameFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(emailFocus);
                                },
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                  labelText: localizations.lastName,
                                  prefixIcon: const Icon(Icons.person_outline),
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// Email Field
                              TextFormField(
                                controller: emailController,
                                enabled: true,
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
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                  labelText: localizations.email,
                                  prefixIcon: const Icon(Icons.email_outlined),
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// Password Field
                              TextFormField(
                                controller: passwordController,
                                obscureText: isPasswordHidden,
                                enabled: true,
                                validator: Validator.password,
                                keyboardType: TextInputType.visiblePassword,
                                focusNode: passwordFocus,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                  labelText: localizations.password,
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordHidden
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordHidden = !isPasswordHidden;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              const OrDivider(),
                              const SizedBox(height: 24),
                              SocialRowWidget(
                                facebookOnTap: () {},
                                googleOnTap: () {},
                                appleOnTap: () {},
                                isLoading: false,
                              ),
                              const SizedBox(height: 24),
                              CustomButton(
                                title: localizations.next,
                                onPressed: () {},
                                isLoading: false,
                              ),
                              const SizedBox(height: 8),
                              HaveAnAccountWidget(
                                onTap: () {},
                                title: localizations.alreadyHaveAnAccount,
                                actionText: localizations.login,
                              ),
                            ],
                          ),
                        ),
                      ],
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
