import '../../domain/entities/exercise_info.dart';
import '../models/exercise_response.dart';
import 'exercise_mapper.dart';

extension ExerciseResponseMapper on ExerciseResponse {
  ExerciseInfo toEntity() {
    return ExerciseInfo(
      message: message,
      totalExercises: totalExercises,
      totalPages: totalPages,
      currentPage: currentPage,
      exercises: exercises?.map((e) => e.toEntity()).toList(),
    );
  }
}
