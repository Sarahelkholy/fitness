import 'package:fitness/config/di/di.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/get_all_muscles_group_entity.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_all_muscles_group_use_case.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';
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
  final GetAllMusclesGroupUseCase _getAllMusclesGroupUseCase;
  final GetDifficultyLevelsUseCase _getDifficultyLevelsUseCase;

  HomeCubit(
    this._getRandomExercisesUseCase,
    this._getFoodCategoriesUseCase,
    this._getAllMusclesGroupUseCase,
    this._getDifficultyLevelsUseCase,
  ) : super(HomeInitial());

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
    String? targetMuscleGroupId,
    String? difficultyLevelId,
    int limit = 3,
  }) async {
    if (state is HomeInitial) {
      emit(HomeLoading());
    }

    String selectedMuscleGroupId = targetMuscleGroupId ?? '';
    String selectedDifficultyLevelId = difficultyLevelId ?? '';

    // 1. Pick a random muscle group if not provided
    if (selectedMuscleGroupId.isEmpty) {
      final musclesResult = await _getAllMusclesGroupUseCase(
        language: AppStrings.current.localeName,
      );
      if (musclesResult is Success<List<GetAllMusclesGroupEntity>> &&
          musclesResult.data.isNotEmpty) {
        final randomGroup = (List.of(musclesResult.data)..shuffle()).first;
        selectedMuscleGroupId = randomGroup.id ?? '69d982ed85f6bfa972bf2218';
      } else {
        selectedMuscleGroupId = '69d982ed85f6bfa972bf2218';
      }
    }

    // 2. Determine user's level from registration / UserCubit if not provided
    if (selectedDifficultyLevelId.isEmpty) {
      final user = getIt<UserCubit>().state.user;
      final userActivityLevel = user?.activityLevel ?? '';

      final levelsResult = await _getDifficultyLevelsUseCase();
      if (levelsResult is Success<List<DifficultyLevel>> &&
          levelsResult.data.isNotEmpty) {
        final levels = levelsResult.data;
        DifficultyLevel? matched;
        if (userActivityLevel.isNotEmpty) {
          matched = levels.firstWhere(
            (l) =>
                (l.name?.toLowerCase().contains(userActivityLevel.toLowerCase()) ?? false) ||
                l.id == userActivityLevel,
            orElse: () => levels.first,
          );
        }
        selectedDifficultyLevelId =
            matched?.id ?? levels.first.id ?? '69d982ed85f6bfa972bf2216';
      } else {
        selectedDifficultyLevelId = '69d982ed85f6bfa972bf2216';
      }
    }

    final result = await _getRandomExercisesUseCase.call(
      targetMuscleGroupId: selectedMuscleGroupId,
      difficultyLevelId: selectedDifficultyLevelId,
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
