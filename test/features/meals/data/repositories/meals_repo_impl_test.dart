import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/meals/data/data_sources/remote/meals_remote_data_source.dart';
import 'package:fitness/features/meals/data/models/responses/category_response.dart';
import 'package:fitness/features/meals/data/models/responses/meal_details_response.dart';
import 'package:fitness/features/meals/data/models/responses/meals_response.dart';
import 'package:fitness/features/meals/data/repositories/meals_repo_impl.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';
import 'package:fitness/features/meals/domain/entities/meal_details_entity.dart';
import 'package:fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_repo_impl_test.mocks.dart';

@GenerateMocks([MealsRemoteDataSource, AppLocalizations])
void main() {
  late MealsRepoImpl repository;
  late MockMealsRemoteDataSource mockRemoteDataSource;
  late MockAppLocalizations mockAppLocalizations;

  late CategoryResponse categoryResponse;
  late MealsResponse mealsResponse;
  late MealDetailsResponse mealDetailsResponse;
  late String errorMessage;

  setUpAll(() {
    mockAppLocalizations = MockAppLocalizations();
    AppStrings.current = mockAppLocalizations;
    when(mockAppLocalizations.mealNotFound).thenReturn('Meal not found');

    errorMessage = "Error";
    categoryResponse = CategoryResponse(
      categories: [
        CategoryModel(
          idCategory: '1',
          strCategory: 'Beef',
          strCategoryThumb: 'url',
          strCategoryDescription: 'desc',
        ),
      ],
    );
    mealsResponse = MealsResponse(
      meals: [MealModel(idMeal: '1', strMeal: 'Steak', strMealThumb: 'url')],
    );
    mealDetailsResponse = MealDetailsResponse(
      meals: [
        MealDetailsModel(
          idMeal: '1',
          strMeal: 'Steak',
          strInstructions: 'Cook it',
          strMealThumb: 'url',
        ),
      ],
    );

    provideDummy<Result<CategoryResponse>>(Success(data: categoryResponse));
    provideDummy<Result<MealsResponse>>(Success(data: mealsResponse));
    provideDummy<Result<MealDetailsResponse>>(
      Success(data: mealDetailsResponse),
    );
  });

  setUp(() {
    mockAppLocalizations = MockAppLocalizations();
    AppStrings.current = mockAppLocalizations;
    when(mockAppLocalizations.mealNotFound).thenReturn('Meal not found');

    mockRemoteDataSource = MockMealsRemoteDataSource();
    repository = MealsRepoImpl(mockRemoteDataSource);
  });

  group("Meals Repo Impl Test Group", () {
    group("Get Categories Function", () {
      group("Success Cases", () {
        test(
          "Test Success Case with mapped entities returned successfully",
          () async {
            when(
              mockRemoteDataSource.getCategories(),
            ).thenAnswer((_) async => Success(data: categoryResponse));

            final result = await repository.getCategories();

            expect(result, isA<Success<List<CategoryEntity>>>());
            final data = (result as Success<List<CategoryEntity>>).data;
            expect(data.length, categoryResponse.categories!.length);
            expect(data[0].name, categoryResponse.categories![0].strCategory);
            verify(mockRemoteDataSource.getCategories()).called(1);
          },
        );
      });

      group("Failure Cases", () {
        test("Test Failure Case with error message", () async {
          when(
            mockRemoteDataSource.getCategories(),
          ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

          final result = await repository.getCategories();

          expect(result, isA<Failure<List<CategoryEntity>>>());
          expect((result as Failure).errorMessage, errorMessage);
          verify(mockRemoteDataSource.getCategories()).called(1);
        });
      });
    });

    group("Get Meals By Category Function", () {
      group("Success Cases", () {
        test(
          "Test Success Case with mapped entities returned successfully",
          () async {
            when(
              mockRemoteDataSource.getMealsByCategory(any),
            ).thenAnswer((_) async => Success(data: mealsResponse));

            final result = await repository.getMealsByCategory('Beef');

            expect(result, isA<Success<List<MealEntity>>>());
            final data = (result as Success<List<MealEntity>>).data;
            expect(data.length, mealsResponse.meals!.length);
            expect(data[0].name, mealsResponse.meals![0].strMeal);
            verify(mockRemoteDataSource.getMealsByCategory('Beef')).called(1);
          },
        );
      });

      group("Failure Cases", () {
        test("Test Failure Case with error message", () async {
          when(
            mockRemoteDataSource.getMealsByCategory(any),
          ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

          final result = await repository.getMealsByCategory('Beef');

          expect(result, isA<Failure<List<MealEntity>>>());
          expect((result as Failure).errorMessage, errorMessage);
          verify(mockRemoteDataSource.getMealsByCategory('Beef')).called(1);
        });
      });
    });

    group("Get Meal Details Function", () {
      group("Success Cases", () {
        test(
          "Test Success Case with mapped entity returned successfully",
          () async {
            when(
              mockRemoteDataSource.getMealDetails(any),
            ).thenAnswer((_) async => Success(data: mealDetailsResponse));

            final result = await repository.getMealDetails('1');

            expect(result, isA<Success<MealDetailsEntity>>());
            final data = (result as Success<MealDetailsEntity>).data;
            expect(data.name, mealDetailsResponse.meals!.first.strMeal);
            verify(mockRemoteDataSource.getMealDetails('1')).called(1);
          },
        );
      });

      group("Failure Cases", () {
        test("Test Failure Case when meal list is empty", () async {
          when(mockRemoteDataSource.getMealDetails(any)).thenAnswer(
            (_) async => Success(data: MealDetailsResponse(meals: [])),
          );

          final result = await repository.getMealDetails('1');

          expect(result, isA<Failure<MealDetailsEntity>>());
          verify(mockRemoteDataSource.getMealDetails('1')).called(1);
        });

        test("Test Failure Case with error message", () async {
          when(
            mockRemoteDataSource.getMealDetails(any),
          ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

          final result = await repository.getMealDetails('1');

          expect(result, isA<Failure<MealDetailsEntity>>());
          expect((result as Failure).errorMessage, errorMessage);
          verify(mockRemoteDataSource.getMealDetails('1')).called(1);
        });
      });
    });
  });
}
