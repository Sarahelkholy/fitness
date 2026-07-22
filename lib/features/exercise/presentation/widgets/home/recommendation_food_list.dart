import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/exercise/data/models/home/home_items_model.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/recommendation_card.dart';
import 'package:flutter/material.dart';

class RecommendationFoodList extends StatelessWidget {
  const RecommendationFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final List<HomeItemsModel> food = [
      HomeItemsModel(title: local.breakfast, icon: AppAssets.breakfastImage),
      HomeItemsModel(title: local.lunch, icon: AppAssets.lunchImage),
      HomeItemsModel(title: local.dinner, icon: AppAssets.dinnerImage),
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: food.length,
        itemBuilder: (context, index) {
          return RecommendationCard(
            title: food[index].title,
            image: food[index].icon,
          );
        },
      ),
    );
  }
}
