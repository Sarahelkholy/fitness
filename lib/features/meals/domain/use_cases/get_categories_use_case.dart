import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/category_entity.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repo.dart';

@injectable
class GetCategoriesUseCase {
  final MealsRepo _repo;

  GetCategoriesUseCase(this._repo);

  Future<Result<List<CategoryEntity>>> call() {
    return _repo.getCategories();
  }
}
