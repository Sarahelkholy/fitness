import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/meal_details_entity.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repo.dart';

@injectable
class GetMealDetailsUseCase {
  final MealsRepo _repo;

  GetMealDetailsUseCase(this._repo);

  Future<Result<MealDetailsEntity>> call(String mealId) {
    return _repo.getMealDetails(mealId);
  }
}
