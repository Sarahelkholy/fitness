import '../../../../../config/error_handling/result.dart';
import '../../models/responses/category_response.dart';
import '../../models/responses/meals_response.dart';
import '../../models/responses/meal_details_response.dart';

abstract class MealsRemoteDataSource {
  Future<Result<CategoryResponse>> getCategories();

  Future<Result<MealsResponse>> getMealsByCategory(String category);

  Future<Result<MealDetailsResponse>> getMealDetails(String mealId);
}
