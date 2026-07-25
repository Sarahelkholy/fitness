import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class InfoChip extends StatelessWidget {
  final String label;
  final bool isHighlight;

  const InfoChip({
    super.key,
    required this.label,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isHighlight
            ? AppColors.main.withValues(alpha: 0.2)
            : AppColors.gray3A,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlight ? AppColors.main : Colors.transparent,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.medium12(
          context,
        ).copyWith(color: isHighlight ? AppColors.main : AppColors.white),
      ),
    );
  }
}
