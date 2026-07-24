import 'dart:ui';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/auth/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:fitness/features/auth/presentation/pages/forget_password/view/widgets/provide_email_view.dart';
import 'package:fitness/features/auth/presentation/pages/forget_password/view/widgets/reset_password_view.dart';
import 'package:fitness/features/auth/presentation/pages/forget_password/view/widgets/verify_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final PageController _pageController = PageController();
  final String _email = '';

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: CustomScaffold(
        backgroundImage: AppAssets.authBackgroundImage,
        body: SizedBox(
          height: mediaQuery.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppBar(
                  title: Image.asset(
                    AppAssets.appLogo,
                    height: mediaQuery.height * 0.05,
                    width: mediaQuery.width * 0.1,
                    fit: BoxFit.fill,
                  ),
                  centerTitle: true,
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: mediaQuery.height * .5,
                      color: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width * .1,
                              vertical: mediaQuery.height * .05,
                            ),
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (page) {
                                setState(() {});
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ProvideEmailView(
                                  onNext: (email) {
                                    _nextPage();
                                  },
                                ),
                                VerifyCodeView(
                                  email: _email,
                                  onNext: () => _nextPage(),
                                ),
                                const ResetPasswordView(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
