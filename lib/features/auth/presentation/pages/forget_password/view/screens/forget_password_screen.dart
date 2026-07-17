import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/shared_widgets/app_scafold.dart';
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

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
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
      create: (_) => getIt<ForgetPasswordCubit>(),
      child: AppScaffold(
        backgroundImage: AppAssets.authBackgroundImage,
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: AppColors.transparent,
                  elevation: 0,
                  leading: InkWell(
                    onTap: _previousPage,
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.main,
                      size: 35,
                    ),
                  ),
                  title: Image.asset(
                    AppAssets.authBackgroundImage,
                    height: 75,
                    width: 90,
                  ),
                ),
                SizedBox(height: size.height * .1),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      ProvideEmailView(
                        onNext: (email) {
                          setState(() {
                            _email = email;
                          });
                          _nextPage();
                        },
                      ),
                      VerifyCodeView(email: _email, onNext: _nextPage),
                      const ResetPasswordView(),
                    ],
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
