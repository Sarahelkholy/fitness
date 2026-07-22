import 'package:equatable/equatable.dart';

class RandomExerciseEntity extends Equatable {
  final String? id;
  final String? exercise;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;

  const RandomExerciseEntity({
    this.id,
    this.exercise,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
  });

  @override
  List<Object?> get props => [
    id,
    exercise,
    difficultyLevel,
    targetMuscleGroup,
    primeMoverMuscle,
  ];
}
