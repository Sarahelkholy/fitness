import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_exercises_use_case.dart';
import 'package:fitness/features/popular_tarining/domain/use_cases/get_random_exercise_use_case.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_cubit.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_training_cubit_test.mocks.dart';

@GenerateMocks([
  GetRandomExerciseUseCase,
  GetExercisesUseCase,
  GetDifficultyLevelsUseCase,
])
void main() {
  provideDummy<Result<List<String>>>(Success(data: const []));
  provideDummy<Result<List<DifficultyLevel>>>(Success(data: const []));
  provideDummy<Result<ExerciseInfo>>(Success(data: const ExerciseInfo()));
  late PopularTrainingCubit cubit;
  late MockGetRandomExerciseUseCase mockGetRandomExerciseUseCase;
  late MockGetExercisesUseCase mockGetExercisesUseCase;
  late MockGetDifficultyLevelsUseCase mockGetDifficultyLevelsUseCase;

  setUp(() {
    mockGetRandomExerciseUseCase = MockGetRandomExerciseUseCase();
    mockGetExercisesUseCase = MockGetExercisesUseCase();
    mockGetDifficultyLevelsUseCase = MockGetDifficultyLevelsUseCase();

    cubit = PopularTrainingCubit(
      mockGetRandomExerciseUseCase,
      mockGetExercisesUseCase,
      mockGetDifficultyLevelsUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('PopularTrainingCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const PopularTrainingStates());
    });

    blocTest<PopularTrainingCubit, PopularTrainingStates>(
      'emits loaded state when data is successfully fetched',
      build: () {
        when(
          mockGetRandomExerciseUseCase.getRandomPrimeMoverMuscles(),
        ).thenAnswer((_) async => Success(data: ['chest', 'back']));

        when(
          mockGetDifficultyLevelsUseCase(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
          ),
        ).thenAnswer(
          (_) async => Success(
            data: [const DifficultyLevel(id: '1', name: 'Beginner')],
          ),
        );

        when(
          mockGetExercisesUseCase(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer(
          (_) async => Success(
            data: const ExerciseInfo(
              totalExercises: 1,
              exercises: [Exercise(id: 'ex1', exercise: 'Push Up')],
            ),
          ),
        );

        return cubit;
      },
      act: (cubit) => cubit.doEvents(const LoadPopularTrainingIntent()),
      expect: () => [
        const PopularTrainingStates(isLoading: true),
        isA<PopularTrainingStates>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.data, 'data', isNotEmpty),
      ],
      verify: (cubit) {
        verify(
          mockGetRandomExerciseUseCase.getRandomPrimeMoverMuscles(),
        ).called(1);
      },
    );
    group('PopularTrainingCubit Errors', () {
      blocTest<PopularTrainingCubit, PopularTrainingStates>(
        'emits error state when getRandomPrimeMoverMuscles returns Failure',
        build: () {
          when(
            mockGetRandomExerciseUseCase.getRandomPrimeMoverMuscles(),
          ).thenAnswer((_) async => Failure(errorMessage: 'Network error'));
          return cubit;
        },
        act: (cubit) => cubit.doEvents(const LoadPopularTrainingIntent()),
        expect: () => [
          const PopularTrainingStates(isLoading: true),
          const PopularTrainingStates(
            isLoading: false,
            errorMessage: 'Network error',
          ),
        ],
      );
    });
  });
}
