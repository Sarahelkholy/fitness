import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  final String title;
  final bool isViewAll;
  final VoidCallback? onViewAllPressed;
  const HeadlineWidget({
    super.key,
    required this.title,
    this.isViewAll = false,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: AppTextStyles.semiBold16(context)),
            ),
            isViewAll
                ? TextButton(
                    onPressed: onViewAllPressed,
                    child: Text(
                      local.seeAll,
                      style: AppTextStyles.regular14(context).copyWith(
                        color: AppColors.main,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
