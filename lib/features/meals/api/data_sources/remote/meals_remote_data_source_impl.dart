import 'package:injectable/injectable.dart';
import '../../../../../config/error_handling/execute_api.dart';
import '../../../../../config/error_handling/result.dart';
import 'package:fitness/features/meals/data/data_sources/remote/meals_remote_data_source.dart';
import '../../../data/models/responses/category_response.dart';
import '../../../data/models/responses/meal_details_response.dart';
import '../../../data/models/responses/meals_response.dart';
import '../../meals_api_client/meals_api_client.dart';

@Injectable(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsApiClient _apiClient;

  MealsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<CategoryResponse>> getCategories() {
    return executeApi(() async {
      return await _apiClient.getCategories();
    });
  }

  @override
  Future<Result<MealsResponse>> getMealsByCategory(String category) {
    return executeApi(() async {
      return await _apiClient.getMealsByCategory(category);
    });
  }

  @override
  Future<Result<MealDetailsResponse>> getMealDetails(String mealId) {
    return executeApi(() async {
      return await _apiClient.getMealDetails(mealId);
    });
  }
}
