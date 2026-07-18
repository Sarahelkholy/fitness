import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(thickness: 1, color: AppColors.grayD3),
          ),
        ),
        Text(
          localizations.or,
          style: AppTextStyles.regular12(
            context,
          ).copyWith(color: AppColors.white),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(thickness: 1, color: AppColors.grayD3),
          ),
        ),
      ],
    );
  }
}
