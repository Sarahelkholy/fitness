import 'package:flutter/material.dart';

import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/values/keys_strings.dart';
import '../../../domain/entities/register_form_data.dart';

class GenderSelectionWidget extends StatelessWidget {
  final UserGender? selectedGender;
  final Function(UserGender) onGenderSelected;

  const GenderSelectionWidget({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        _GenderButton(
          key: const Key(KeysStrings.registerFormMaleButton),
          gender: UserGender.male,
          isSelected: selectedGender == UserGender.male,
          onTap: () => onGenderSelected(UserGender.male),
          icon: Icons.male,
          label: localizations.male,
        ),
        const SizedBox(height: 24),
        _GenderButton(
          key: const Key(KeysStrings.registerFormFemaleButton),
          gender: UserGender.female,
          isSelected: selectedGender == UserGender.female,
          onTap: () => onGenderSelected(UserGender.female),
          icon: Icons.female,
          label: localizations.female,
        ),
      ],
    );
  }
}

class _GenderButton extends StatelessWidget {
  final UserGender gender;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String label;

  const _GenderButton({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.main : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.main : AppColors.white,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 60, color: AppColors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.semiBold12(
                context,
              ).copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
