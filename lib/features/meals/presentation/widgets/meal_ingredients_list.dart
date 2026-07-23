import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/meal_details_entity.dart';

class MealIngredientsList extends StatelessWidget {
  final List<IngredientEntity> ingredients;

  const MealIngredientsList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCharcoal.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: ingredients.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.gray3A, height: 24),
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ingredient.name,
                  style: AppTextStyles.semiBold16(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ),
              Text(
                ingredient.measure,
                style: AppTextStyles.medium14(
                  context,
                ).copyWith(color: AppColors.main),
              ),
            ],
          );
        },
      ),
    );
  }
}
