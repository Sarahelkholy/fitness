import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/meal_entity.dart';

class MealRecommendationState extends Equatable {
  final BaseState<List<CategoryEntity>> categoriesState;
  final BaseState<List<MealEntity>> mealsState;

  const MealRecommendationState({
    this.categoriesState = const BaseState(),
    this.mealsState = const BaseState(),
  });

  MealRecommendationState copyWith({
    BaseState<List<CategoryEntity>>? categoriesStateParam,
    BaseState<List<MealEntity>>? mealsStateParam,
  }) {
    return MealRecommendationState(
      categoriesState: categoriesStateParam ?? categoriesState,
      mealsState: mealsStateParam ?? mealsState,
    );
  }

  @override
  List<Object?> get props => [categoriesState, mealsState];
}
