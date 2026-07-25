import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/meals/domain/entities/meal_details_entity.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repo.dart';
import 'package:fitness/features/meals/domain/use_cases/get_meal_details_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_meal_details_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  late GetMealDetailsUseCase getMealDetailsUseCase;
  late MockMealsRepo mockMealsRepo;

  late MealDetailsEntity mealDetailsEntity;
  late String errorMessage;

  setUpAll(() {
    errorMessage = "Error";
    mealDetailsEntity = const MealDetailsEntity(
      id: '1',
      name: 'Steak',
      mealAlternate: '',
      category: 'Beef',
      area: 'British',
      country: 'UK',
      instructions: 'Cook it',
      image: 'url',
      tags: '',
      youtubeUrl: '',
      sourceUrl: '',
      imageSource: '',
      creativeCommonsConfirmed: '',
      dateModified: '',
      ingredients: [],
    );

    provideDummy<Result<MealDetailsEntity>>(Success(data: mealDetailsEntity));
  });

  setUp(() {
    mockMealsRepo = MockMealsRepo();
    getMealDetailsUseCase = GetMealDetailsUseCase(mockMealsRepo);
  });

  group("Get Meal Details UseCase Test Group", () {
    const mealId = '1';
    group("Success Cases", () {
      test(
        "Test Success Case with meal details returned successfully",
        () async {
          when(
            mockMealsRepo.getMealDetails(mealId),
          ).thenAnswer((_) async => Success(data: mealDetailsEntity));

          final result = await getMealDetailsUseCase(mealId);

          expect(result, isA<Success<MealDetailsEntity>>());
          expect(
            (result as Success<MealDetailsEntity>).data.name,
            mealDetailsEntity.name,
          );
          verify(mockMealsRepo.getMealDetails(mealId)).called(1);
        },
      );
    });

    group("Failure Cases", () {
      test("Test Failure Case with error message", () async {
        when(
          mockMealsRepo.getMealDetails(mealId),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

        final result = await getMealDetailsUseCase(mealId);

        expect(result, isA<Failure<MealDetailsEntity>>());
        expect((result as Failure).errorMessage, errorMessage);
        verify(mockMealsRepo.getMealDetails(mealId)).called(1);
      });
    });
  });
}
