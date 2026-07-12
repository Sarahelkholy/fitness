import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.radiusValue = 100,
    this.isLoading = false,
    this.titleStyle,
    this.borderColor,
  });

  final String title;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? radiusValue;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue!),
          side: BorderSide(
            color: onPressed == null || isLoading
                ? AppColors.grayD3
                : borderColor ?? AppColors.main,
            width: 1,
          ),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              title,
              style:
                  titleStyle ??
                  AppTextStyles.medium16(
                    context,
                  ).copyWith(color: foregroundColor),
            ),
    );
  }
}
