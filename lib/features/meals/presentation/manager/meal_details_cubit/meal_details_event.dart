sealed class MealDetailsEvents {}

class GetMealDetailsEvent extends MealDetailsEvents {
  final String mealId;

  GetMealDetailsEvent({required this.mealId});
}

class PlayVideoEvent extends MealDetailsEvents {}
