import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CategoryTabBar extends StatelessWidget {
  final List categories;
  final int selectedIndex;
  final Function(int index) onTap;

  const CategoryTabBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = categories.length + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(itemCount, (index) {
          final isSelected = index == selectedIndex;
          final isAll = index == 0;
          final category = isAll ? null : categories[index - 1];

          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isAll ? 'Full Body' : category.name,
                    style: AppTextStyles.regular16(context).copyWith(
                      color: isSelected
                          ? AppColors.grayD3
                          : AppColors.grayD3,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 8),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 7,
                    width: 30,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.main
                          : AppColors.transparentColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}