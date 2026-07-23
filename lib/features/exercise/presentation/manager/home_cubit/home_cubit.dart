import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_random_exercises_use_case.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_events.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_state.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';
import 'package:fitness/features/meals/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetRandomExercisesUseCase _getRandomExercisesUseCase;
  final GetCategoriesUseCase _getFoodCategoriesUseCase;

  HomeCubit(this._getRandomExercisesUseCase, this._getFoodCategoriesUseCase)
    : super(HomeInitial());

  void doEvents(HomeEvents event) {
    switch (event) {
      case GetRandomExercises():
        _getRandomExercises(
          targetMuscleGroupId: event.targetMuscleGroupId,
          difficultyLevelId: event.difficultyLevelId,
          limit: event.limit,
        );
        break;
      case GetFoodCategories():
        _getFoodCategories();
        break;
    }
  }

  Future<void> _getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  }) async {
    if (state is HomeInitial) {
      emit(HomeLoading());
    }

    final result = await _getRandomExercisesUseCase.call(
      targetMuscleGroupId: targetMuscleGroupId,
      difficultyLevelId: difficultyLevelId,
      limit: limit,
    );

    switch (result) {
      case Success<RandomExercisesResponseEntity>():
        final currentState = state is HomeSuccess
            ? (state as HomeSuccess)
            : const HomeSuccess();
        emit(currentState.copyWith(randomExercisesResponseEntity: result.data));
        break;
      case Failure<RandomExercisesResponseEntity>():
        emit(HomeFailure(errorMessage: result.errorMessage));
        break;
    }
  }

  Future<void> _getFoodCategories() async {
    if (state is HomeInitial) {
      emit(HomeLoading());
    }

    final result = await _getFoodCategoriesUseCase.call();

    switch (result) {
      case Success<List<CategoryEntity>>():
        final currentState = state is HomeSuccess
            ? (state as HomeSuccess)
            : const HomeSuccess();
        emit(currentState.copyWith(foodCategories: result.data));
        break;
      case Failure<List<CategoryEntity>>():
        emit(HomeFailure(errorMessage: result.errorMessage));
        break;
    }
  }
}
