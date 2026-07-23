import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: "categories")
  List<CategoryModel>? categories;

  CategoryResponse({this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: "idCategory")
  String? idCategory;
  @JsonKey(name: "strCategory")
  String? strCategory;
  @JsonKey(name: "strCategoryThumb")
  String? strCategoryThumb;
  @JsonKey(name: "strCategoryDescription")
  String? strCategoryDescription;

  CategoryModel({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
