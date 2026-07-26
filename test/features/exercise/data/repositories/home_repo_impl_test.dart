import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/data/data_sources/home_remote_data_source.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';
import 'package:fitness/features/exercise/data/repositories/home_repo_impl.dart';
import 'package:fitness/features/exercise/domain/entities/get_all_muscles_group_entity.dart';
import 'package:fitness/features/exercise/domain/entities/get_muscles_by_group_id_entity.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/data/models/exercise_response.dart';
import 'package:fitness/features/exercise/domain/entities/exercise_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeRemoteDataSource>()])
void main() {
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late HomeRepoImpl repository;

  setUpAll(() {
    provideDummy<Result<RandomExercisesResponse>>(
      Success(data: RandomExercisesResponse()),
    );
    provideDummy<Result<GetAllMusclesGroupResponse>>(
      Success(data: GetAllMusclesGroupResponse()),
    );
    provideDummy<Result<GetMusclesGroupIdResponse>>(
      Success(data: GetMusclesGroupIdResponse()),
    );
  });

  setUp(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepoImpl(mockHomeRemoteDataSource);
  });

  group('getRandomExercises', () {
    test(
      'should return Success<RandomExercisesResponseEntity> when data source succeeds',
      () async {
        final tResponse = RandomExercisesResponse(
          message: 'Success',
          totalMuscles: 0,
          muscles: [],
        );

        when(
          mockHomeRemoteDataSource.getRandomExercises(),
        ).thenAnswer((_) async => Success(data: tResponse));

        final result = await repository.getRandomExercises();

        expect(result, isA<Success<RandomExercisesResponseEntity>>());
        expect(
          (result as Success<RandomExercisesResponseEntity>).data.message,
          equals('Success'),
        );
        verify(mockHomeRemoteDataSource.getRandomExercises()).called(1);
      },
    );

    test('should return Failure when data source fails', () async {
      const tError = 'Something went wrong';

      when(
        mockHomeRemoteDataSource.getRandomExercises(),
      ).thenAnswer((_) async => Failure(errorMessage: tError));

      final result = await repository.getRandomExercises();

      expect(result, isA<Failure<RandomExercisesResponseEntity>>());
      expect(
        (result as Failure<RandomExercisesResponseEntity>).errorMessage,
        equals(tError),
      );
    });
  });

  group('getAllMusclesGroup', () {
    const tLanguage = 'en';

    test(
      'should return Success<List<GetAllMusclesGroupEntity>> when data source succeeds',
      () async {
        final tResponse = GetAllMusclesGroupResponse(
          message: 'Success',
          musclesGroup: [MusclesGroup(id: '1', name: 'Biceps')],
        );

        when(
          mockHomeRemoteDataSource.getAllMusclesGroup(language: tLanguage),
        ).thenAnswer((_) async => Success(data: tResponse));

        final result = await repository.getAllMusclesGroup(language: tLanguage);

        expect(result, isA<Success<List<GetAllMusclesGroupEntity>>>());
        final data = (result as Success<List<GetAllMusclesGroupEntity>>).data;
        expect(data.length, equals(1));
        expect(data.first.id, equals('1'));
        expect(data.first.name, equals('Biceps'));
      },
    );

    test('should return Failure when data source fails', () async {
      const tError = 'Error fetching muscles group';

      when(
        mockHomeRemoteDataSource.getAllMusclesGroup(language: tLanguage),
      ).thenAnswer((_) async => Failure(errorMessage: tError));

      final result = await repository.getAllMusclesGroup(language: tLanguage);

      expect(result, isA<Failure<List<GetAllMusclesGroupEntity>>>());
      expect(
        (result as Failure<List<GetAllMusclesGroupEntity>>).errorMessage,
        equals(tError),
      );
    });
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
          mockHomeRemoteDataSource.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenAnswer((_) async => tExerciseResponse);

        // act
        final result = await repository.getExercises(page: 1);

        // assert
        expect(result, isA<Success<ExerciseInfo>>());
        verify(mockHomeRemoteDataSource.getExercises(page: 1));
      },
    );

    test(
      'should return Failure when remote data source throws exception',
      () async {
        // arrange
        when(
          mockHomeRemoteDataSource.getExercises(
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

  group('getMusclesByGroupId', () {
    const tLanguage = 'en';
    const tMuscleGroupId = 'grp_123';

    test(
      'should return Success<List<GetMusclesByGroupIdEntity>> when data source succeeds',
      () async {
        final tResponse = GetMusclesGroupIdResponse(
          message: 'Success',
          totalMuscles: 1,
          muscles: [MusclesID(id: 'm1', name: 'Arm', image: 'arm.png')],
        );

        when(
          mockHomeRemoteDataSource.getMuscleGroupId(
            language: tLanguage,
            muscleGroupId: tMuscleGroupId,
          ),
        ).thenAnswer((_) async => Success(data: tResponse));

        final result = await repository.getMusclesByGroupId(
          language: tLanguage,
          muscleGroupId: tMuscleGroupId,
        );

        expect(result, isA<Success<List<GetMusclesByGroupIdEntity>>>());
        final data = (result as Success<List<GetMusclesByGroupIdEntity>>).data;
        expect(data.length, equals(1));
        expect(data.first.id, equals('m1'));
      },
    );

    test('should return Failure when data source fails', () async {
      const tError = 'Failed to fetch muscle group by ID';

      when(
        mockHomeRemoteDataSource.getMuscleGroupId(
          language: tLanguage,
          muscleGroupId: tMuscleGroupId,
        ),
      ).thenAnswer((_) async => Failure(errorMessage: tError));

      final result = await repository.getMusclesByGroupId(
        language: tLanguage,
        muscleGroupId: tMuscleGroupId,
      );

      expect(result, isA<Failure<List<GetMusclesByGroupIdEntity>>>());
      expect(
        (result as Failure<List<GetMusclesByGroupIdEntity>>).errorMessage,
        equals(tError),
      );
    });
  });
}
