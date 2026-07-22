import '../../domain/entities/category_entity.dart';
import '../models/responses/category_response.dart';

extension CategoryMapper on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: idCategory ?? "",
      name: strCategory ?? "",
      image: strCategoryThumb ?? "",
      description: strCategoryDescription ?? "",
    );
  }
}
