import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/models/exercise_response.dart';
import 'package:fitness/features/exercise/data/repositories/home_repo_impl.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late HomeRepoImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepoImpl(mockRemoteDataSource);
  });

  group('getExercises', () {
    final tExerciseResponse = ExerciseResponse(
      exercises: [],
      totalExercises: 0,
      totalPages: 0,
      currentPage: 1,
    );

    test(
      'should return Success when remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenAnswer((_) async => tExerciseResponse);

        // act
        final result = await repository.getExercises(page: 1);

        // assert
        expect(result, isA<Success<ExerciseInfo>>());
        verify(mockRemoteDataSource.getExercises(page: 1));
      },
    );

    test(
      'should return Failure when remote data source throws exception',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenThrow(Exception('Server Error'));

        // act
        final result = await repository.getExercises(page: 1);

        // assert
        expect(result, isA<Failure<ExerciseInfo>>());
      },
    );
  });
}
