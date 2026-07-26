import 'package:equatable/equatable.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_entity.dart';

class RandomExercisesResponseEntity extends Equatable {
  final String? message;
  final int? totalMuscles;
  final List<RandomExerciseEntity>? muscles;

  const RandomExercisesResponseEntity({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  @override
  List<Object?> get props => [message, totalMuscles, muscles];
}
