import 'package:equatable/equatable.dart';

class MealDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String mealAlternate;
  final String category;
  final String area;
  final String country;
  final String instructions;
  final String image;
  final String tags;
  final String youtubeUrl;
  final String sourceUrl;
  final String imageSource;
  final String creativeCommonsConfirmed;
  final String dateModified;
  final List<IngredientEntity> ingredients;

  const MealDetailsEntity({
    required this.id,
    required this.name,
    required this.mealAlternate,
    required this.category,
    required this.area,
    required this.country,
    required this.instructions,
    required this.image,
    required this.tags,
    required this.youtubeUrl,
    required this.sourceUrl,
    required this.imageSource,
    required this.creativeCommonsConfirmed,
    required this.dateModified,
    required this.ingredients,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    mealAlternate,
    category,
    area,
    country,
    instructions,
    image,
    tags,
    youtubeUrl,
    sourceUrl,
    imageSource,
    creativeCommonsConfirmed,
    dateModified,
    ingredients,
  ];
}

class IngredientEntity extends Equatable {
  final String name;
  final String measure;

  const IngredientEntity({required this.name, required this.measure});

  @override
  List<Object?> get props => [name, measure];
}
