sealed class MealRecommendationEvents {}

class GetCategoriesEvent extends MealRecommendationEvents {
  final int initialIndex;

  GetCategoriesEvent({this.initialIndex = 0});
}

class GetMealsByCategoryEvent extends MealRecommendationEvents {
  final String category;
  final int index;

  GetMealsByCategoryEvent({required this.category, required this.index});
}
