sealed class MealRecommendationEvents {}

class GetCategoriesEvent extends MealRecommendationEvents {}

class GetMealsByCategoryEvent extends MealRecommendationEvents {
  final String category;
  final int index;

  GetMealsByCategoryEvent({required this.category, required this.index});
}
