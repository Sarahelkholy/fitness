import '../../../domain/entities/register_form_params.dart';

sealed class RegisterFormEvents {}

class PickGenderEvent extends RegisterFormEvents {
  final UserGender gender;

  PickGenderEvent({required this.gender});
}

class PickAgeEvent extends RegisterFormEvents {
  final num age;

  PickAgeEvent({required this.age});
}

class PickWeightEvent extends RegisterFormEvents {
  final num weight;

  PickWeightEvent({required this.weight});
}

class PickHeightEvent extends RegisterFormEvents {
  final num height;

  PickHeightEvent({required this.height});
}

class PickGoalEvent extends RegisterFormEvents {
  final UserGoal goal;

  PickGoalEvent({required this.goal});
}

class PickActivityLevelEvent extends RegisterFormEvents {
  final ActivityLevel activityLevel;

  PickActivityLevelEvent({required this.activityLevel});
}

class SubmitRegisterFormEvent extends RegisterFormEvents {}
