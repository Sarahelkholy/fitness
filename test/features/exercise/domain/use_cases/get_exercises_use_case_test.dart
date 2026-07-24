import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:fitness/features/exercise/domain/repositories/home_repo.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_exercises_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_exercises_use_case_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late GetExercisesUseCase useCase;
  late MockHomeRepo mockHomeRepo;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    useCase = GetExercisesUseCase(mockHomeRepo);
  });

  const tExerciseInfo = ExerciseInfo(
    results: [Exercise(id: '1', exercise: 'Push Up')],
    metadata: null,
  );

  test('should get exercises from the repository', () async {
    // arrange
    when(mockHomeRepo.getExercises(
      primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
      difficultyLevelId: anyNamed('difficultyLevelId'),
      page: anyNamed('page'),
    )).thenAnswer((_) async => Success(tExerciseInfo));

    // act
    final result = await useCase.call(page: 1);

    // assert
    expect(result, Success(tExerciseInfo));
    verify(mockHomeRepo.getExercises(page: 1));
    verifyNoMoreInteractions(mockHomeRepo);
  });
}
