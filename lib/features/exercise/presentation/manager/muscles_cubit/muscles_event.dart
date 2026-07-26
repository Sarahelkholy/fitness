sealed class MusclesEvent {}

///? =======================Get All Muscles =====================
class GetAllMusclesEvent extends MusclesEvent {
  GetAllMusclesEvent({required this.language});
  final String language;
}

class GetWorkoutsByMuscleGroupIdEvent extends MusclesEvent {
  GetWorkoutsByMuscleGroupIdEvent({
    required this.language,
    required this.muscleGroupId,
    required this.index,
  });
  final String language;
  final String muscleGroupId;
  final int index;
}
