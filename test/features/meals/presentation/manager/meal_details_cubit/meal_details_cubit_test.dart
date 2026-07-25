import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/meals/domain/entities/meal_details_entity.dart';
import 'package:fitness/features/meals/domain/use_cases/get_meal_details_use_case.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_cubit.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_event.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_details_cubit_test.mocks.dart';

@GenerateMocks([GetMealDetailsUseCase])
void main() {
  late MealDetailsCubit mealDetailsCubit;
  late MockGetMealDetailsUseCase mockGetMealDetailsUseCase;

  late MealDetailsEntity mealDetailsEntity;
  late String errorMessage;

  setUpAll(() {
    errorMessage = "Error";
    mealDetailsEntity = const MealDetailsEntity(
      id: '1',
      name: 'Meal',
      mealAlternate: '',
      category: '',
      area: '',
      country: '',
      instructions: '',
      image: '',
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
    mockGetMealDetailsUseCase = MockGetMealDetailsUseCase();
    mealDetailsCubit = MealDetailsCubit(mockGetMealDetailsUseCase);
  });

  group("Meal Details Cubit Test Group", () {
    test("initial state should be MealDetailsState", () {
      expect(mealDetailsCubit.state, const MealDetailsState());
    });

    group("Get Meal Details Event Test Group", () {
      const mealId = '1';
      group("Success Cases", () {
        blocTest<MealDetailsCubit, MealDetailsState>(
          "should emit loading then success when get meal details succeeds",
          setUp: () {
            when(
              mockGetMealDetailsUseCase.call(mealId),
            ).thenAnswer((_) async => Success(data: mealDetailsEntity));
          },
          build: () => mealDetailsCubit,
          act: (cubit) => cubit.doEvents(GetMealDetailsEvent(mealId: mealId)),
          expect: () => [
            const MealDetailsState(
              mealDetailsState: BaseState(isLoading: true),
              showYoutubePlayer: false,
            ),
            MealDetailsState(
              mealDetailsState: BaseState(
                isLoading: false,
                isSuccess: true,
                data: mealDetailsEntity,
              ),
              showYoutubePlayer: false,
            ),
          ],
          verify: (_) {
            verify(mockGetMealDetailsUseCase.call(mealId)).called(1);
          },
        );
      });

      group("Failure Cases", () {
        blocTest<MealDetailsCubit, MealDetailsState>(
          "should emit loading then failure when get meal details fails",
          setUp: () {
            when(
              mockGetMealDetailsUseCase.call(mealId),
            ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
          },
          build: () => mealDetailsCubit,
          act: (cubit) => cubit.doEvents(GetMealDetailsEvent(mealId: mealId)),
          expect: () => [
            const MealDetailsState(
              mealDetailsState: BaseState(isLoading: true),
              showYoutubePlayer: false,
            ),
            MealDetailsState(
              mealDetailsState: BaseState(
                isLoading: false,
                isSuccess: false,
                errorMessage: errorMessage,
              ),
              showYoutubePlayer: false,
            ),
          ],
          verify: (_) {
            verify(mockGetMealDetailsUseCase.call(mealId)).called(1);
          },
        );
      });
    });

    group("Play Video Event Test Group", () {
      blocTest<MealDetailsCubit, MealDetailsState>(
        "should update showYoutubePlayer to true",
        build: () => mealDetailsCubit,
        act: (cubit) => cubit.doEvents(PlayVideoEvent()),
        expect: () => [const MealDetailsState(showYoutubePlayer: true)],
      );
    });
  });
}
