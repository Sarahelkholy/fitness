import 'package:fitness/features/exercise/data/models/difficulty_level_response.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';

class PopularTrainingItem {
  final Exercise exercise;
  final List<DifficultyLevel> levels;
  final int exerciseCount;
  final String displayLevel;

  const PopularTrainingItem({
    required this.exercise,
    required this.levels,
    required this.exerciseCount,
    required this.displayLevel,
  });
}
