import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.actionText,
  });

  final GestureTapCallback onTap;
  final String title;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: AppTextStyles.regular14(context).copyWith(
                color: AppColors.white,
              ),
            ),
            const TextSpan(text: ' '),
            TextSpan(
              text: actionText,
              style: AppTextStyles.extraBold14(context).copyWith(
                decoration: TextDecoration.underline,
                color: AppColors.main,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
