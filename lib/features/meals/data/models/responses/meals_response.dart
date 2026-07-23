import 'package:json_annotation/json_annotation.dart';

part 'meals_response.g.dart';

@JsonSerializable()
class MealsResponse {
  @JsonKey(name: "meals")
  List<MealModel>? meals;

  MealsResponse({this.meals});

  factory MealsResponse.fromJson(Map<String, dynamic> json) =>
      _$MealsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealsResponseToJson(this);
}

@JsonSerializable()
class MealModel {
  @JsonKey(name: "strMeal")
  String? strMeal;
  @JsonKey(name: "strMealThumb")
  String? strMealThumb;
  @JsonKey(name: "idMeal")
  String? idMeal;
  @JsonKey(name: "strArea")
  String? strArea;
  @JsonKey(name: "strCountry")
  String? strCountry;

  MealModel({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
    this.strArea,
    this.strCountry,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);
}
