sealed class HomeEvents {}

class GetRandomExercises extends HomeEvents {
  final String targetMuscleGroupId;
  final String difficultyLevelId;
  final int limit;

  GetRandomExercises({
    required this.targetMuscleGroupId,
    required this.difficultyLevelId,
    this.limit = 3,
  });
}

class GetFoodCategories extends HomeEvents {}
