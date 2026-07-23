import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/core/localization/l10n/app_localizations_en.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/exercise/api/api_client/home_api_client.dart';
import 'package:fitness/features/exercise/api/data_sources/home_remote_data_source_impl.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';
import 'package:fitness/features/exercise/data/models/response/get_muscles_group_id_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeApiClient>()])
void main() {
  late MockHomeApiClient mockHomeApiClient;
  late HomeRemoteDataSourceImpl dataSource;

  setUpAll(() {
    AppStrings.current = AppLocalizationsEn();
  });

  setUp(() {
    mockHomeApiClient = MockHomeApiClient();
    dataSource = HomeRemoteDataSourceImpl(mockHomeApiClient);
  });

  group('getRandomExercises', () {
    const tTargetMuscleGroupId = '123';
    const tDifficultyLevelId = '456';
    const tLimit = 3;

    test('should return Success<RandomExercisesResponse> when call to apiClient is successful', () async {
      final tResponse = RandomExercisesResponse(
        message: 'Success',
        totalExercises: 1,
        exercises: [],
      );

      when(mockHomeApiClient.getRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      )).thenAnswer((_) async => tResponse);

      final result = await dataSource.getRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      );

      expect(result, isA<Success<RandomExercisesResponse>>());
      expect((result as Success<RandomExercisesResponse>).data, equals(tResponse));
      verify(mockHomeApiClient.getRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      )).called(1);
    });

    test('should return Failure when call to apiClient throws an Exception', () async {
      when(mockHomeApiClient.getRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      )).thenThrow(Exception('Network Error'));

      final result = await dataSource.getRandomExercises(
        targetMuscleGroupId: tTargetMuscleGroupId,
        difficultyLevelId: tDifficultyLevelId,
        limit: tLimit,
      );

      expect(result, isA<Failure<RandomExercisesResponse>>());
    });
  });

  group('getAllMusclesGroup', () {
    const tLanguage = 'en';

    test('should return Success<GetAllMusclesGroupResponse> when call to apiClient is successful', () async {
      final tResponse = GetAllMusclesGroupResponse(message: 'Success', musclesGroup: []);

      when(mockHomeApiClient.getAllMusclesGroup(tLanguage)).thenAnswer((_) async => tResponse);

      final result = await dataSource.getAllMusclesGroup(language: tLanguage);

      expect(result, isA<Success<GetAllMusclesGroupResponse>>());
      expect((result as Success<GetAllMusclesGroupResponse>).data, equals(tResponse));
      verify(mockHomeApiClient.getAllMusclesGroup(tLanguage)).called(1);
    });

    test('should return Failure when call to apiClient throws an Exception', () async {
      when(mockHomeApiClient.getAllMusclesGroup(tLanguage)).thenThrow(Exception('Server Error'));

      final result = await dataSource.getAllMusclesGroup(language: tLanguage);

      expect(result, isA<Failure<GetAllMusclesGroupResponse>>());
    });
  });

  group('getMuscleGroupId', () {
    const tLanguage = 'en';
    const tMuscleGroupId = 'grp_123';

    test('should return Success<GetMusclesGroupIdResponse> when call to apiClient is successful', () async {
      final tResponse = GetMusclesGroupIdResponse(message: 'Success', totalMuscles: 0, muscles: []);

      when(mockHomeApiClient.getMuscleGroupId(tLanguage, tMuscleGroupId)).thenAnswer((_) async => tResponse);

      final result = await dataSource.getMuscleGroupId(
        language: tLanguage,
        muscleGroupId: tMuscleGroupId,
      );

      expect(result, isA<Success<GetMusclesGroupIdResponse>>());
      expect((result as Success<GetMusclesGroupIdResponse>).data, equals(tResponse));
      verify(mockHomeApiClient.getMuscleGroupId(tLanguage, tMuscleGroupId)).called(1);
    });

    test('should return Failure when call to apiClient throws an Exception', () async {
      when(mockHomeApiClient.getMuscleGroupId(tLanguage, tMuscleGroupId)).thenThrow(Exception('Error'));

      final result = await dataSource.getMuscleGroupId(
        language: tLanguage,
        muscleGroupId: tMuscleGroupId,
      );

      expect(result, isA<Failure<GetMusclesGroupIdResponse>>());
    });
  });
}
