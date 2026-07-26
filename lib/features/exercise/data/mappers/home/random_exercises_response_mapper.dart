import 'package:fitness/features/exercise/data/mappers/home/random_exercise_mapper.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';

extension RandomExercisesResponseMapper on RandomExercisesResponse {
  RandomExercisesResponseEntity toEntity() {
    return RandomExercisesResponseEntity(
      message: message,
      totalMuscles: totalMuscles,
      muscles: muscles?.map((muscleModel) => muscleModel.toEntity()).toList(),
    );
  }
}
