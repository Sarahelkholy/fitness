import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/error_handling/result.dart';
import '../../../domain/use_cases/get_categories_use_case.dart';
import '../../../domain/use_cases/get_meals_by_category_use_case.dart';
import 'meal_recommendation_event.dart';
import 'meal_recommendation_state.dart';

@injectable
class MealRecommendationCubit
    extends BaseCubit<MealRecommendationState, BaseEvent> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetMealsByCategoryUseCase _getMealsByCategoryUseCase;

  MealRecommendationCubit(
    this._getCategoriesUseCase,
    this._getMealsByCategoryUseCase,
  ) : super(const MealRecommendationState());

  void doEvents(MealRecommendationEvents event) {
    switch (event) {
      case GetCategoriesEvent():
        _getCategories();
      case GetMealsByCategoryEvent():
        _getMealsByCategory(event.category, event.index);
    }
  }

  Future<void> _getCategories() async {
    emit(
      state.copyWith(
        categoriesStateParam: const BaseState(isLoading: true),
        selectedCategoryIndexParam: 0,
      ),
    );

    final result = await _getCategoriesUseCase.call();

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            categoriesStateParam: BaseState(isSuccess: true, data: result.data),
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            categoriesStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  Future<void> _getMealsByCategory(String category, int index) async {
    emit(state.copyWith(
      mealsStateParam: const BaseState(isLoading: true),
      selectedCategoryIndexParam: index,
    ));

    final result = await _getMealsByCategoryUseCase.call(category);

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            mealsStateParam: BaseState(isSuccess: true, data: result.data),
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            mealsStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }
}
