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
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetRandomExercisesUseCase>(),
  MockSpec<GetCategoriesUseCase>(),
])
void main() {
  late MockGetRandomExercisesUseCase mockGetRandomExercisesUseCase;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late HomeCubit homeCubit;

  const tLanguage = 'en';
  const tEntity = RandomExercisesResponseEntity(
    message: 'Success',
    totalMuscles: 0,
    muscles: [],
  );
  final tCategories = <CategoryEntity>[];

  setUpAll(() {
    provideDummy<Result<RandomExercisesResponseEntity>>(
      Success(data: tEntity),
    );
    provideDummy<Result<List<CategoryEntity>>>(
      Success(data: <CategoryEntity>[]),
    );
  });

  setUp(() {
    mockGetRandomExercisesUseCase = MockGetRandomExercisesUseCase();
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    homeCubit = HomeCubit(
      mockGetRandomExercisesUseCase,
      mockGetCategoriesUseCase,
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  test('initial state should be HomeInitial', () {
    expect(homeCubit.state, equals(HomeInitial()));
  });

  group('GetRandomExercises Event', () {
    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeSuccess] when GetRandomExercises succeeds',
      build: () {
        when(mockGetRandomExercisesUseCase.call(language: tLanguage))
            .thenAnswer((_) async => Success(data: tEntity));
        return homeCubit;
      },
      act: (cubit) => cubit.doEvents(GetRandomExercises(language: tLanguage)),
      expect: () => [
        HomeLoading(),
        const HomeSuccess(randomExercisesResponseEntity: tEntity),
      ],
      verify: (_) {
        verify(
          mockGetRandomExercisesUseCase.call(language: tLanguage),
        ).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeFailure] when GetRandomExercises fails',
      build: () {
        when(mockGetRandomExercisesUseCase.call(language: tLanguage))
            .thenAnswer(
          (_) async => Failure(errorMessage: 'Error loading exercises'),
        );
        return homeCubit;
      },
      act: (cubit) => cubit.doEvents(GetRandomExercises(language: tLanguage)),
      expect: () => [
        HomeLoading(),
        const HomeFailure(errorMessage: 'Error loading exercises'),
      ],
    );
  });

  group('GetFoodCategories Event', () {
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
        when(mockGetCategoriesUseCase.call()).thenAnswer(
          (_) async => Failure(errorMessage: 'Error loading categories'),
        );
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
