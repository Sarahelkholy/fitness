import '../../domain/entities/meal_entity.dart';
import '../models/responses/meals_response.dart';

extension MealMapper on MealModel {
  MealEntity toEntity() {
    return MealEntity(
      id: idMeal ?? "",
      name: strMeal ?? "",
      image: strMealThumb ?? "",
      area: strArea ?? "",
      country: strCountry ?? "",
    );
  }
}
