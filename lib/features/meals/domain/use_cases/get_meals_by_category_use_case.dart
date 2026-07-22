import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/meal_entity.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repo.dart';

@injectable
class GetMealsByCategoryUseCase {
  final MealsRepo _repo;

  GetMealsByCategoryUseCase(this._repo);

  Future<Result<List<MealEntity>>> call(String category) {
    return _repo.getMealsByCategory(category);
  }
}
