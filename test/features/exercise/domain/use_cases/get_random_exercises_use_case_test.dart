import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_random_exercises_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_random_exercises_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeRepo>()])
void main() {
  late MockHomeRepo mockHomeRepo;
  late GetRandomExercisesUseCase useCase;

  setUpAll(() {
    provideDummy<Result<RandomExercisesResponseEntity>>(
      Success(
        data: const RandomExercisesResponseEntity(
          message: 'Success',
          totalMuscles: 0,
          muscles: [],
        ),
      ),
    );
  });

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    useCase = GetRandomExercisesUseCase(mockHomeRepo);
  });

  test(
    'should return Success<RandomExercisesResponseEntity> when repository call succeeds',
    () async {
      const tEntity = RandomExercisesResponseEntity(
        message: 'Success',
        totalMuscles: 0,
        muscles: [],
      );

      when(
        mockHomeRepo.getRandomExercises(),
      ).thenAnswer((_) async => Success(data: tEntity));

      final result = await useCase.call();

      expect(result, isA<Success<RandomExercisesResponseEntity>>());
      expect(
        (result as Success<RandomExercisesResponseEntity>).data,
        equals(tEntity),
      );
      verify(mockHomeRepo.getRandomExercises()).called(1);
    },
  );

  test('should return Failure when repository call fails', () async {
    const tError = 'Repo Error';

    when(
      mockHomeRepo.getRandomExercises(),
    ).thenAnswer((_) async => Failure(errorMessage: tError));

    final result = await useCase.call();

    expect(result, isA<Failure<RandomExercisesResponseEntity>>());
    expect(
      (result as Failure<RandomExercisesResponseEntity>).errorMessage,
      equals(tError),
    );
    verify(mockHomeRepo.getRandomExercises()).called(1);
  });
}
