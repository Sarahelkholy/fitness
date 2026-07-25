sealed class MusclesEvent {}

///? =======================Get All Muscles =====================
class GetAllMuscles extends MusclesEvent {
  GetAllMuscles({required this.language});
  final String language;
}

class GetMusclesId extends MusclesEvent {
  GetMusclesId({required this.language, required this.muscleGroupId});
  final String language;
  final String muscleGroupId;
}
