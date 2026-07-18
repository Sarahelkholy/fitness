import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class SelectionOption<T> {
  final T value;
  final String label;

  SelectionOption({required this.value, required this.label});
}

class SelectionListWidget<T> extends StatelessWidget {
  final T? selectedValue;
  final List<SelectionOption<T>> options;
  final Function(T) onSelected;

  const SelectionListWidget({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        final isSelected = option.value == selectedValue;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            onTap: () => onSelected(option.value),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected ? AppColors.main : AppColors.grayD3,
                ),
                color: isSelected
                    ? AppColors.main.withValues(alpha: 0.1)
                    : AppColors.grayD3.withValues(alpha: 0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option.label,
                    style: AppTextStyles.bold14(context).copyWith(
                      color: isSelected ? AppColors.main : AppColors.white,
                    ),
                  ),
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected ? AppColors.main : AppColors.grayD3,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
