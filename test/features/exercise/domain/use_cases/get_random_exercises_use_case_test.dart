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
          totalExercises: 0,
          exercises: [],
        ),
      ),
    );
  });

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    useCase = GetRandomExercisesUseCase(mockHomeRepo);
  });

  const tTargetMuscleGroupId = '123';
  const tDifficultyLevelId = '456';
  const tLimit = 3;

  test(
    'should return Success<RandomExercisesResponseEntity> when repository call succeeds',
    () async {
      const tEntity = RandomExercisesResponseEntity(
        message: 'Success',
        totalExercises: 0,
        exercises: [],
      );

      when(
        mockHomeRepo.getRandomExercises(
          targetMuscleGroupId: tTargetMuscleGroupId,
          difficultyLevelId: tDifficultyLevelId,
          limit: tLimit,
        ),
      ).thenAnswer((_) async => Success(data: tEntity));

      final result = await useCase.call(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      );

      expect(result, isA<Success<RandomExercisesResponseEntity>>());
      expect(
        (result as Success<RandomExercisesResponseEntity>).data,
        equals(tEntity),
      );
      verify(
        mockHomeRepo.getRandomExercises(
          targetMuscleGroupId: tTargetMuscleGroupId,
          difficultyLevelId: tDifficultyLevelId,
          limit: tLimit,
        ),
      ).called(1);
    },
  );

  test('should return Failure when repository call fails', () async {
    const tError = 'Repo Error';

    when(
      mockHomeRepo.getRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      ),
    ).thenAnswer((_) async => Failure(errorMessage: tError));

    final result = await useCase.call(
      targetMuscleGroupId: tTargetMuscleGroupId,
      difficultyLevelId: tDifficultyLevelId,
      limit: tLimit,
    );

    expect(result, isA<Failure<RandomExercisesResponseEntity>>());
    expect(
      (result as Failure<RandomExercisesResponseEntity>).errorMessage,
      equals(tError),
    );
    verify(
      mockHomeRepo.getRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      ),
    ).called(1);
  });
}
