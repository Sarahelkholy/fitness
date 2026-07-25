import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repo.dart';
import 'package:fitness/features/meals/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_categories_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  late GetCategoriesUseCase getCategoriesUseCase;
  late MockMealsRepo mockMealsRepo;

  late List<CategoryEntity> categoryEntities;
  late String errorMessage;

  setUpAll(() {
    errorMessage = "Error";
    categoryEntities = [
      const CategoryEntity(
        id: '1',
        name: 'Beef',
        image: 'url',
        description: 'desc',
      ),
    ];

    provideDummy<Result<List<CategoryEntity>>>(Success(data: categoryEntities));
  });

  setUp(() {
    mockMealsRepo = MockMealsRepo();
    getCategoriesUseCase = GetCategoriesUseCase(mockMealsRepo);
  });

  group("Get Categories UseCase Test Group", () {
    group("Success Cases", () {
      test("Test Success Case with categories returned successfully", () async {
        when(
          mockMealsRepo.getCategories(),
        ).thenAnswer((_) async => Success(data: categoryEntities));

        final result = await getCategoriesUseCase();

        expect(result, isA<Success<List<CategoryEntity>>>());
        expect(
          (result as Success<List<CategoryEntity>>).data.length,
          categoryEntities.length,
        );
        verify(mockMealsRepo.getCategories()).called(1);
      });
    });

    group("Failure Cases", () {
      test("Test Failure Case with error message", () async {
        when(
          mockMealsRepo.getCategories(),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

        final result = await getCategoriesUseCase();

        expect(result, isA<Failure<List<CategoryEntity>>>());
        expect((result as Failure).errorMessage, errorMessage);
        verify(mockMealsRepo.getCategories()).called(1);
      });
    });
  });
}
