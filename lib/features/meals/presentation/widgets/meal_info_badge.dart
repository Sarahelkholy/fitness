import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class MealInfoBadge extends StatelessWidget {
  final String label;
  final String value;

  const MealInfoBadge({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.main, width: 1.5),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.darkCharcoal.withValues(alpha: .8),
      ),
      child: Column(
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.regular12(
              context,
            ).copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bold12(
              context,
            ).copyWith(color: AppColors.main),
          ),
        ],
      ),
    );
  }
}
