import '../../../../config/error_handling/result.dart';
import '../entities/category_entity.dart';
import '../entities/meal_details_entity.dart';
import '../entities/meal_entity.dart';

abstract class MealsRepo {
  Future<Result<List<CategoryEntity>>> getCategories();

  Future<Result<List<MealEntity>>> getMealsByCategory(String category);

  Future<Result<MealDetailsEntity>> getMealDetails(String mealId);
}
