import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/meal_entity.dart';

class MealRecommendationState extends Equatable {
  final BaseState<List<CategoryEntity>> categoriesState;
  final BaseState<List<MealEntity>> mealsState;
  final int selectedCategoryIndex;

  const MealRecommendationState({
    this.categoriesState = const BaseState(),
    this.mealsState = const BaseState(),
    this.selectedCategoryIndex = 0,
  });

  MealRecommendationState copyWith({
    BaseState<List<CategoryEntity>>? categoriesStateParam,
    BaseState<List<MealEntity>>? mealsStateParam,
    int? selectedCategoryIndexParam,
  }) {
    return MealRecommendationState(
      categoriesState: categoriesStateParam ?? categoriesState,
      mealsState: mealsStateParam ?? mealsState,
      selectedCategoryIndex:
          selectedCategoryIndexParam ?? selectedCategoryIndex,
    );
  }

  @override
  List<Object?> get props => [
    categoriesState,
    mealsState,
    selectedCategoryIndex,
  ];
}
