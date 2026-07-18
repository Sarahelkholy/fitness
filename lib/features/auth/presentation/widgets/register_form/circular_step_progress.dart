import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class CircularStepProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const CircularStepProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = currentStep / totalSteps;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: progress,
            color: AppColors.main,
            backgroundColor: Colors.transparent,
            strokeWidth: 4,
          ),
        ),
        Text(
          "$currentStep/$totalSteps",
          style: AppTextStyles.bold16(context).copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
