import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repo.dart';
import 'package:fitness/features/meals/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_meals_by_category_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  late GetMealsByCategoryUseCase getMealsByCategoryUseCase;
  late MockMealsRepo mockMealsRepo;

  late List<MealEntity> mealEntities;
  late String errorMessage;

  setUpAll(() {
    errorMessage = "Error";
    mealEntities = [
      const MealEntity(
        id: '1',
        name: 'Steak',
        image: 'url',
        area: 'British',
        country: 'UK',
      ),
    ];

    provideDummy<Result<List<MealEntity>>>(Success(data: mealEntities));
  });

  setUp(() {
    mockMealsRepo = MockMealsRepo();
    getMealsByCategoryUseCase = GetMealsByCategoryUseCase(mockMealsRepo);
  });

  group("Get Meals By Category UseCase Test Group", () {
    const category = 'Beef';
    group("Success Cases", () {
      test("Test Success Case with meals returned successfully", () async {
        when(
          mockMealsRepo.getMealsByCategory(category),
        ).thenAnswer((_) async => Success(data: mealEntities));

        final result = await getMealsByCategoryUseCase(category);

        expect(result, isA<Success<List<MealEntity>>>());
        expect(
          (result as Success<List<MealEntity>>).data.length,
          mealEntities.length,
        );
        verify(mockMealsRepo.getMealsByCategory(category)).called(1);
      });
    });

    group("Failure Cases", () {
      test("Test Failure Case with error message", () async {
        when(
          mockMealsRepo.getMealsByCategory(category),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

        final result = await getMealsByCategoryUseCase(category);

        expect(result, isA<Failure<List<MealEntity>>>());
        expect((result as Failure).errorMessage, errorMessage);
        verify(mockMealsRepo.getMealsByCategory(category)).called(1);
      });
    });
  });
}
