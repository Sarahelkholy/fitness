import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_random_exercises_use_case.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_cubit.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_events.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_state.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';
import 'package:fitness/features/meals/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fitness/features/exercise/domain/use_cases/get_all_muscles_group_use_case.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';

class MockGetRandomExercisesUseCase extends Mock
    implements GetRandomExercisesUseCase {}

class MockGetCategoriesUseCase extends Mock
    implements GetCategoriesUseCase {}

class MockGetAllMusclesGroupUseCase extends Mock
    implements GetAllMusclesGroupUseCase {}

class MockGetDifficultyLevelsUseCase extends Mock
    implements GetDifficultyLevelsUseCase {}
void main() {
  late MockGetRandomExercisesUseCase mockGetRandomExercisesUseCase;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockGetAllMusclesGroupUseCase mockGetAllMusclesGroupUseCase;
  late MockGetDifficultyLevelsUseCase mockGetDifficultyLevelsUseCase;
  late HomeCubit homeCubit;

  setUpAll(() {
    provideDummy<Result<RandomExercisesResponseEntity>>(
      Success(
        data: const RandomExercisesResponseEntity(
          message: 'Success',
          totalExercises: 0,
          exercises: [],
        ),
      ),
    );
    provideDummy<Result<List<CategoryEntity>>>(
      Success(data: <CategoryEntity>[]),
    );
  });

  setUp(() {
    mockGetRandomExercisesUseCase = MockGetRandomExercisesUseCase();
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockGetAllMusclesGroupUseCase = MockGetAllMusclesGroupUseCase();
    mockGetDifficultyLevelsUseCase = MockGetDifficultyLevelsUseCase();
    homeCubit = HomeCubit(
      mockGetRandomExercisesUseCase,
      mockGetCategoriesUseCase,
      mockGetAllMusclesGroupUseCase,
      mockGetDifficultyLevelsUseCase,
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  test('initial state should be HomeInitial', () {
    expect(homeCubit.state, equals(HomeInitial()));
  });

  group('GetRandomExercises Event', () {
    const tTargetMuscleGroupId = '123';
    const tDifficultyLevelId = '456';
    const tLimit = 3;
    const tEntity = RandomExercisesResponseEntity(
      message: 'Success',
      totalExercises: 0,
      exercises: [],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeSuccess] when GetRandomExercises succeeds',
      build: () {
        when(mockGetRandomExercisesUseCase.call(
          targetMuscleGroupId: tTargetMuscleGroupId,
          difficultyLevelId: tDifficultyLevelId,
          limit: tLimit,
        )).thenAnswer((_) async => Success(data: tEntity));
        return homeCubit;
      },
      act: (cubit) => cubit.doEvents(GetRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      )),
      expect: () => [
        HomeLoading(),
        const HomeSuccess(randomExercisesResponseEntity: tEntity),
      ],
      verify: (_) {
        verify(mockGetRandomExercisesUseCase.call(
          targetMuscleGroupId: tTargetMuscleGroupId,
          difficultyLevelId: tDifficultyLevelId,
          limit: tLimit,
        )).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeFailure] when GetRandomExercises fails',
      build: () {
        when(mockGetRandomExercisesUseCase.call(
          targetMuscleGroupId: tTargetMuscleGroupId,
          difficultyLevelId: tDifficultyLevelId,
          limit: tLimit,
        )).thenAnswer((_) async => Failure(errorMessage: 'Error loading exercises'));
        return homeCubit;
      },
      act: (cubit) => cubit.doEvents(GetRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      )),
      expect: () => [
        HomeLoading(),
        const HomeFailure(errorMessage: 'Error loading exercises'),
      ],
    );
  });

  group('GetFoodCategories Event', () {
    final tCategories = <CategoryEntity>[];

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeSuccess] when GetFoodCategories succeeds',
      build: () {
        when(mockGetCategoriesUseCase.call())
            .thenAnswer((_) async => Success(data: tCategories));
        return homeCubit;
      },
      act: (cubit) => cubit.doEvents(GetFoodCategories()),
      expect: () => [
        HomeLoading(),
        HomeSuccess(foodCategories: tCategories),
      ],
      verify: (_) {
        verify(mockGetCategoriesUseCase.call()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeFailure] when GetFoodCategories fails',
      build: () {
        when(mockGetCategoriesUseCase.call())
            .thenAnswer((_) async => Failure(errorMessage: 'Error loading categories'));
        return homeCubit;
      },
      act: (cubit) => cubit.doEvents(GetFoodCategories()),
      expect: () => [
        HomeLoading(),
        const HomeFailure(errorMessage: 'Error loading categories'),
      ],
    );
  });
}
