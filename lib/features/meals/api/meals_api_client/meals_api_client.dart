import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/values/api_end_points.dart';
import '../../../../core/values/api_strings.dart';
import '../../data/models/responses/category_response.dart';
import '../../data/models/responses/meals_response.dart';
import '../../data/models/responses/meal_details_response.dart';

part 'meals_api_client.g.dart';

@injectable
@RestApi()
abstract class MealsApiClient {
  @factoryMethod
  factory MealsApiClient(@Named(ApiStrings.mealsDio) Dio dio) = _MealsApiClient;

  @GET(ApiEndPoints.getMealsCategories)
  Future<CategoryResponse> getCategories();

  @GET(ApiEndPoints.getMealsByCategory)
  Future<MealsResponse> getMealsByCategory(
      @Query(ApiStrings.categoryParam) String category,);

  @GET(ApiEndPoints.getMealDetails)
  Future<MealDetailsResponse> getMealDetails(
      @Query(ApiStrings.mealIdParam) String mealId,);
}
