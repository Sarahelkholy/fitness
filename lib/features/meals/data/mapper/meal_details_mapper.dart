import '../../domain/entities/meal_details_entity.dart';
import '../models/responses/meal_details_response.dart';

extension MealDetailsMapper on MealDetailsModel {
  MealDetailsEntity toEntity() {
    return MealDetailsEntity(
      id: idMeal ?? "",
      name: strMeal ?? "",
      mealAlternate: strMealAlternate ?? "",
      category: strCategory ?? "",
      area: strArea ?? "",
      country: strCountry ?? "",
      instructions: strInstructions ?? "",
      image: strMealThumb ?? "",
      tags: strTags ?? "",
      youtubeUrl: strYoutube ?? "",
      sourceUrl: strSource ?? "",
      imageSource: strImageSource ?? "",
      creativeCommonsConfirmed: strCreativeCommonsConfirmed ?? "",
      dateModified: dateModified ?? "",
      ingredients: _getIngredients(),
    );
  }

  List<IngredientEntity> _getIngredients() {
    final List<IngredientEntity> ingredients = [];

    _addIfNotEmpty(ingredients, strIngredient1, strMeasure1);
    _addIfNotEmpty(ingredients, strIngredient2, strMeasure2);
    _addIfNotEmpty(ingredients, strIngredient3, strMeasure3);
    _addIfNotEmpty(ingredients, strIngredient4, strMeasure4);
    _addIfNotEmpty(ingredients, strIngredient5, strMeasure5);
    _addIfNotEmpty(ingredients, strIngredient6, strMeasure6);
    _addIfNotEmpty(ingredients, strIngredient7, strMeasure7);
    _addIfNotEmpty(ingredients, strIngredient8, strMeasure8);
    _addIfNotEmpty(ingredients, strIngredient9, strMeasure9);
    _addIfNotEmpty(ingredients, strIngredient10, strMeasure10);
    _addIfNotEmpty(ingredients, strIngredient11, strMeasure11);
    _addIfNotEmpty(ingredients, strIngredient12, strMeasure12);
    _addIfNotEmpty(ingredients, strIngredient13, strMeasure13);
    _addIfNotEmpty(ingredients, strIngredient14, strMeasure14);
    _addIfNotEmpty(ingredients, strIngredient15, strMeasure15);
    _addIfNotEmpty(ingredients, strIngredient16, strMeasure16);
    _addIfNotEmpty(ingredients, strIngredient17, strMeasure17);
    _addIfNotEmpty(ingredients, strIngredient18, strMeasure18);
    _addIfNotEmpty(ingredients, strIngredient19, strMeasure19);
    _addIfNotEmpty(ingredients, strIngredient20, strMeasure20);

    return ingredients;
  }

  void _addIfNotEmpty(List<IngredientEntity> list,
      String? name,
      String? measure,) {
    if (name != null && name
        .trim()
        .isNotEmpty) {
      list.add(IngredientEntity(name: name, measure: measure ?? ""));
    }
  }
}
