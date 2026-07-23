sealed class MealRecommendationEvents {}

class GetCategoriesEvent extends MealRecommendationEvents {}

class GetMealsByCategoryEvent extends MealRecommendationEvents {
  final String category;

  GetMealsByCategoryEvent({required this.category});
}
