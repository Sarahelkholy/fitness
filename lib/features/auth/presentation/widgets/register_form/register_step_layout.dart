import 'dart:ui';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/shared_widgets/custom_button.dart';
import '../../../../../core/utils/app_text_styles.dart';

class RegisterStepLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final bool isLoading;
  final Key? buttonKey;

  const RegisterStepLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    this.isLoading = false,
    this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.extraBold20(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: AppTextStyles.regular16(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    content,
                    const SizedBox(height: 32),
                    CustomButton(
                      key: buttonKey,
                      title: buttonText,
                      onPressed: onButtonPressed,
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
