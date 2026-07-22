import 'package:equatable/equatable.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_entity.dart';

class RandomExercisesResponseEntity extends Equatable {
  final String? message;
  final int? totalExercises;
  final List<RandomExerciseEntity>? exercises;

  const RandomExercisesResponseEntity({
    this.message,
    this.totalExercises,
    this.exercises,
  });

  @override
  List<Object?> get props => [message, totalExercises, exercises];
}
