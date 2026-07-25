import 'package:equatable/equatable.dart';
import '../exercise.dart';

class RandomExerciseEntity extends Equatable {
  final String? id;
  final String? exercise;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;
  final String? primeMoverMuscleId;
  final String? shortYoutubeDemonstrationLink;

  const RandomExerciseEntity({
    this.id,
    this.exercise,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.primeMoverMuscleId,
    this.shortYoutubeDemonstrationLink,
  });

  Exercise toExercise() {
    return Exercise(
      id: id,
      exercise: exercise,
      difficultyLevel: difficultyLevel,
      targetMuscleGroup: targetMuscleGroup,
      primeMoverMuscle: primeMoverMuscle,
      shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink,
    );
  }

  @override
  List<Object?> get props => [
    id,
    exercise,
    difficultyLevel,
    targetMuscleGroup,
    primeMoverMuscle,
    primeMoverMuscleId,
    shortYoutubeDemonstrationLink,
  ];
}
