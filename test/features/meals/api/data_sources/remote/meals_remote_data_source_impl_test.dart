import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/meals/api/data_sources/remote/meals_remote_data_source_impl.dart';
import 'package:fitness/features/meals/api/meals_api_client/meals_api_client.dart';
import 'package:fitness/features/meals/data/models/responses/category_response.dart';
import 'package:fitness/features/meals/data/models/responses/meal_details_response.dart';
import 'package:fitness/features/meals/data/models/responses/meals_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([MealsApiClient, AppLocalizations])
void main() {
  late MealsRemoteDataSourceImpl mealsRemoteDataSourceImpl;
  late MockMealsApiClient mockMealsApiClient;
  late MockAppLocalizations mockAppLocalizations;

  late CategoryResponse categoryResponse;
  late MealsResponse mealsResponse;
  late MealDetailsResponse mealDetailsResponse;

  setUpAll(() {
    mockAppLocalizations = MockAppLocalizations();
    AppStrings.current = mockAppLocalizations;

    categoryResponse = CategoryResponse(categories: []);
    mealsResponse = MealsResponse(meals: []);
    mealDetailsResponse = MealDetailsResponse(meals: []);

    // Stub common error strings used in NetworkException
    when(mockAppLocalizations.unexpectedErrorMessage).thenReturn('Error');
  });

  setUp(() {
    mockAppLocalizations = MockAppLocalizations();
    AppStrings.current = mockAppLocalizations;
    when(mockAppLocalizations.unexpectedErrorMessage).thenReturn('Error');

    mockMealsApiClient = MockMealsApiClient();
    mealsRemoteDataSourceImpl = MealsRemoteDataSourceImpl(mockMealsApiClient);
  });

  group("Meals Remote Data Source Test Group", () {
    group("Get Categories Function", () {
      group("Success Cases", () {
        test("Test Success Case when api call succeeds", () async {
          when(
            mockMealsApiClient.getCategories(),
          ).thenAnswer((_) async => categoryResponse);

          final result = await mealsRemoteDataSourceImpl.getCategories();

          expect(result, isA<Success<CategoryResponse>>());
          expect((result as Success<CategoryResponse>).data, categoryResponse);
          verify(mockMealsApiClient.getCategories()).called(1);
        });
      });

      group("Failure Cases", () {
        test("Test Failure Case when api throws exception", () async {
          when(mockMealsApiClient.getCategories()).thenThrow(Exception());

          final result = await mealsRemoteDataSourceImpl.getCategories();

          expect(result, isA<Failure<CategoryResponse>>());
          expect((result as Failure).errorMessage, isNotEmpty);
          verify(mockMealsApiClient.getCategories()).called(1);
        });
      });
    });

    group("Get Meals By Category Function", () {
      const category = 'Beef';
      group("Success Cases", () {
        test("Test Success Case when api call succeeds", () async {
          when(
            mockMealsApiClient.getMealsByCategory(category),
          ).thenAnswer((_) async => mealsResponse);

          final result = await mealsRemoteDataSourceImpl.getMealsByCategory(
            category,
          );

          expect(result, isA<Success<MealsResponse>>());
          expect((result as Success<MealsResponse>).data, mealsResponse);
          verify(mockMealsApiClient.getMealsByCategory(category)).called(1);
        });
      });

      group("Failure Cases", () {
        test("Test Failure Case when api throws exception", () async {
          when(
            mockMealsApiClient.getMealsByCategory(any),
          ).thenThrow(Exception());

          final result = await mealsRemoteDataSourceImpl.getMealsByCategory(
            category,
          );

          expect(result, isA<Failure<MealsResponse>>());
          expect((result as Failure).errorMessage, isNotEmpty);
          verify(mockMealsApiClient.getMealsByCategory(category)).called(1);
        });
      });
    });

    group("Get Meal Details Function", () {
      const mealId = '1';
      group("Success Cases", () {
        test("Test Success Case when api call succeeds", () async {
          when(
            mockMealsApiClient.getMealDetails(mealId),
          ).thenAnswer((_) async => mealDetailsResponse);

          final result = await mealsRemoteDataSourceImpl.getMealDetails(mealId);

          expect(result, isA<Success<MealDetailsResponse>>());
          expect(
            (result as Success<MealDetailsResponse>).data,
            mealDetailsResponse,
          );
          verify(mockMealsApiClient.getMealDetails(mealId)).called(1);
        });
      });

      group("Failure Cases", () {
        test("Test Failure Case when api throws exception", () async {
          when(mockMealsApiClient.getMealDetails(any)).thenThrow(Exception());

          final result = await mealsRemoteDataSourceImpl.getMealDetails(mealId);

          expect(result, isA<Failure<MealDetailsResponse>>());
          expect((result as Failure).errorMessage, isNotEmpty);
          verify(mockMealsApiClient.getMealDetails(mealId)).called(1);
        });
      });
    });
  });
}
