import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/exercise/data/models/home/home_items_model.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final List<HomeItemsModel> categories = [
      HomeItemsModel(title: local.gym, icon: AppAssets.gymCategoryIcon),
      HomeItemsModel(title: local.fitness, icon: AppAssets.fitnessCategoryIcon),
      HomeItemsModel(title: local.yoga, icon: AppAssets.yogaCategoryIcon),
      HomeItemsModel(
        title: local.aerobics,
        icon: AppAssets.aerobicCategoryIcon,
      ),
      HomeItemsModel(title: local.trainer, icon: AppAssets.trainerCategoryIcon),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColors.darkCharcoal.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(categories.length, (index) {
          final item = categories[index];

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (item.title == local.trainer) {
                        Navigator.pushNamed(context, Routes.smartCoachRoute);
                      } else {
                        Navigator.pushNamed(
                          context,
                          Routes.upcomingFeatureRoute,
                        );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          item.icon,
                          height: 56,
                          width: 56,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          style: AppTextStyles.regular12(context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                if (index != categories.length - 1)
                  Container(
                    height: 40,
                    width: 0.5,
                    color: AppColors.white.withOpacity(0.1),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
