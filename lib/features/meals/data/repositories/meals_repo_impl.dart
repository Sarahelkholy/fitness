import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../core/values/app_strings.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/meal_details_entity.dart';
import '../../domain/entities/meal_entity.dart';
import 'package:fitness/features/meals/data/data_sources/remote/meals_remote_data_source.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repo.dart';
import '../mapper/category_mapper.dart';
import '../mapper/meal_details_mapper.dart';
import '../mapper/meal_mapper.dart';
import '../models/responses/category_response.dart';
import '../models/responses/meal_details_response.dart';
import '../models/responses/meals_response.dart';

@Injectable(as: MealsRepo)
class MealsRepoImpl implements MealsRepo {
  final MealsRemoteDataSource _remoteDataSource;

  MealsRepoImpl(this._remoteDataSource);

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    final result = await _remoteDataSource.getCategories();
    switch (result) {
      case Success<CategoryResponse>():
        return Success(
          data: result.data.categories?.map((e) => e.toEntity()).toList() ?? [],
        );
      case Failure<CategoryResponse>():
        return Failure(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<List<MealEntity>>> getMealsByCategory(String category) async {
    final result = await _remoteDataSource.getMealsByCategory(category);
    switch (result) {
      case Success<MealsResponse>():
        return Success(
          data: result.data.meals?.map((e) => e.toEntity()).toList() ?? [],
        );
      case Failure<MealsResponse>():
        return Failure(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<MealDetailsEntity>> getMealDetails(String mealId) async {
    final result = await _remoteDataSource.getMealDetails(mealId);
    switch (result) {
      case Success<MealDetailsResponse>():
        if (result.data.meals != null && result.data.meals!.isNotEmpty) {
          return Success(data: result.data.meals!.first.toEntity());
        }
        return Failure(errorMessage: AppStrings.current.mealNotFound);
      case Failure<MealDetailsResponse>():
        return Failure(errorMessage: result.errorMessage);
    }
  }
}
