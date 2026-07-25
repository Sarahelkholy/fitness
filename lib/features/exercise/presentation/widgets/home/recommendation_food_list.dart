import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/recommendation_card.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class RecommendationFoodList extends StatelessWidget {
  final List<CategoryEntity> categories;

  const RecommendationFoodList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length > 4 ? 4 : categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.mealRecommendationRoute,
                arguments: index,
              );
            },
            child: RecommendationCard(
              title: categories[index].name,
              image: categories[index].image,
            ),
          );
        },
      ),
    );
  }
}
