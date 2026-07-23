import 'package:equatable/equatable.dart';
import 'exercise.dart';

class ExerciseInfo extends Equatable {
  final String? message;
  final int? totalExercises;
  final int? totalPages;
  final int? currentPage;
  final List<Exercise>? exercises;

  const ExerciseInfo({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  @override
  List<Object?> get props => [
        message,
        totalExercises,
        totalPages,
        currentPage,
        exercises,
      ];
}
