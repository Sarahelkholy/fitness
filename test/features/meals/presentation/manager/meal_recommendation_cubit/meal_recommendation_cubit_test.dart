import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';
import 'package:fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:fitness/features/meals/domain/use_cases/get_categories_use_case.dart';
import 'package:fitness/features/meals/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_cubit.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_event.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_recommendation_cubit_test.mocks.dart';

@GenerateMocks([GetCategoriesUseCase, GetMealsByCategoryUseCase])
void main() {
  late MealRecommendationCubit mealRecommendationCubit;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockGetMealsByCategoryUseCase mockGetMealsByCategoryUseCase;

  late List<CategoryEntity> categoryEntities;
  late List<MealEntity> mealEntities;
  late String errorMessage;

  setUpAll(() {
    errorMessage = "Error";
    categoryEntities = [
      const CategoryEntity(id: '1', name: 'Beef', image: '', description: ''),
    ];
    mealEntities = [
      const MealEntity(
        id: '1',
        name: 'Steak',
        image: '',
        area: '',
        country: '',
      ),
    ];

    provideDummy<Result<List<CategoryEntity>>>(Success(data: categoryEntities));
    provideDummy<Result<List<MealEntity>>>(Success(data: mealEntities));
  });

  setUp(() {
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockGetMealsByCategoryUseCase = MockGetMealsByCategoryUseCase();
    mealRecommendationCubit = MealRecommendationCubit(
      mockGetCategoriesUseCase,
      mockGetMealsByCategoryUseCase,
    );
  });

  group("Meal Recommendation Cubit Test Group", () {
    test("initial state should be MealRecommendationState", () {
      expect(mealRecommendationCubit.state, const MealRecommendationState());
    });

    group("Get Categories Event Test Group", () {
      group("Success Cases", () {
        blocTest<MealRecommendationCubit, MealRecommendationState>(
          "should emit loading then success when get categories succeeds",
          setUp: () {
            when(
              mockGetCategoriesUseCase.call(),
            ).thenAnswer((_) async => Success(data: categoryEntities));
            when(
              mockGetMealsByCategoryUseCase.call(categoryEntities[0].name),
            ).thenAnswer((_) async => Success(data: mealEntities));
          },
          build: () => mealRecommendationCubit,
          act: (cubit) => cubit.doEvents(GetCategoriesEvent()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            const MealRecommendationState(
              categoriesState: BaseState(isLoading: true),
              selectedCategoryIndex: 0,
            ),
            MealRecommendationState(
              categoriesState: BaseState(
                isLoading: false,
                isSuccess: true,
                data: categoryEntities,
              ),
              selectedCategoryIndex: 0,
            ),
            MealRecommendationState(
              categoriesState: BaseState(
                isLoading: false,
                isSuccess: true,
                data: categoryEntities,
              ),
              mealsState: const BaseState(isLoading: true),
              selectedCategoryIndex: 0,
            ),
            MealRecommendationState(
              categoriesState: BaseState(
                isLoading: false,
                isSuccess: true,
                data: categoryEntities,
              ),
              mealsState: BaseState(
                isLoading: false,
                isSuccess: true,
                data: mealEntities,
              ),
              selectedCategoryIndex: 0,
            ),
          ],
          verify: (_) {
            verify(mockGetCategoriesUseCase.call()).called(1);
            verify(
              mockGetMealsByCategoryUseCase.call(categoryEntities[0].name),
            ).called(1);
          },
        );
      });

      group("Failure Cases", () {
        blocTest<MealRecommendationCubit, MealRecommendationState>(
          "should emit loading then failure when get categories fails",
          setUp: () {
            when(
              mockGetCategoriesUseCase.call(),
            ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
          },
          build: () => mealRecommendationCubit,
          act: (cubit) => cubit.doEvents(GetCategoriesEvent()),
          expect: () => [
            const MealRecommendationState(
              categoriesState: BaseState(isLoading: true),
              selectedCategoryIndex: 0,
            ),
            MealRecommendationState(
              categoriesState: BaseState(
                isLoading: false,
                isSuccess: false,
                errorMessage: errorMessage,
              ),
              selectedCategoryIndex: 0,
            ),
          ],
          verify: (_) {
            verify(mockGetCategoriesUseCase.call()).called(1);
          },
        );
      });
    });

    group("Get Meals By Category Event Test Group", () {
      const category = 'Beef';
      const index = 1;
      group("Success Cases", () {
        blocTest<MealRecommendationCubit, MealRecommendationState>(
          "should emit loading then success when get meals succeeds",
          setUp: () {
            when(
              mockGetMealsByCategoryUseCase.call(category),
            ).thenAnswer((_) async => Success(data: mealEntities));
          },
          build: () => mealRecommendationCubit,
          act: (cubit) => cubit.doEvents(
            GetMealsByCategoryEvent(category: category, index: index),
          ),
          expect: () => [
            const MealRecommendationState(
              mealsState: BaseState(isLoading: true),
              selectedCategoryIndex: index,
            ),
            MealRecommendationState(
              mealsState: BaseState(
                isLoading: false,
                isSuccess: true,
                data: mealEntities,
              ),
              selectedCategoryIndex: index,
            ),
          ],
          verify: (_) {
            verify(mockGetMealsByCategoryUseCase.call(category)).called(1);
          },
        );
      });

      group("Failure Cases", () {
        blocTest<MealRecommendationCubit, MealRecommendationState>(
          "should emit loading then failure when get meals fails",
          setUp: () {
            when(
              mockGetMealsByCategoryUseCase.call(category),
            ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
          },
          build: () => mealRecommendationCubit,
          act: (cubit) => cubit.doEvents(
            GetMealsByCategoryEvent(category: category, index: index),
          ),
          expect: () => [
            const MealRecommendationState(
              mealsState: BaseState(isLoading: true),
              selectedCategoryIndex: index,
            ),
            MealRecommendationState(
              mealsState: BaseState(
                isLoading: false,
                isSuccess: false,
                errorMessage: errorMessage,
              ),
              selectedCategoryIndex: index,
            ),
          ],
          verify: (_) {
            verify(mockGetMealsByCategoryUseCase.call(category)).called(1);
          },
        );
      });
    });
  });
}
