import 'dart:ui';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
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
  int _currentPage = 0;
  String _email = '';

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
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
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: CustomScaffold(
        backgroundImage: AppAssets.authBackgroundImage,
        body: SizedBox(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppBar(
                  title: Image.asset(
                    AppAssets.appLogo,
                    height: 48,
                    width: 70,
                    fit: BoxFit.fill,
                  ),

                  centerTitle: true,
                ),
                SizedBox(height: size.height * .1),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              // color: AppColors.pureBlack.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            child: SizedBox(
                              height: 380, // Approximate height to fit content
                              child: PageView(
                                controller: _pageController,
                                onPageChanged: (page) {
                                  setState(() {
                                    _currentPage = page;
                                  });
                                },
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  ProvideEmailView(
                                    onNext: (email) {
                                      setState(() => _email = email);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
