import 'package:fitness/features/exercise/data/models/exercise_dto.dart';
import 'package:fitness/features/exercise/data/mapper/exercise_mapper.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tExerciseDto = ExerciseDto(
    id: '1',
    exercise: 'Push Up',
    shortYoutubeDemonstrationLink: 'https://youtube.com/watch?v=123',
  );

  group('ExerciseDto', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "_id": "1",
        "exercise": "Push Up",
        "short_youtube_demonstration_link": "https://youtube.com/watch?v=123",
      };

      // act
      final result = ExerciseDto.fromJson(jsonMap);

      // assert
      expect(result.id, tExerciseDto.id);
      expect(result.exercise, tExerciseDto.exercise);
    });

    test('toEntity should convert DTO to Exercise entity', () {
      // act
      final result = tExerciseDto.toEntity();

      // assert
      expect(result, isA<Exercise>());
      expect(result.id, tExerciseDto.id);
      expect(result.exercise, tExerciseDto.exercise);
    });
  });
}
