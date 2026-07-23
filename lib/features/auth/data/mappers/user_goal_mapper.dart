import '../../domain/entities/register_form_data.dart';

extension UserGoalExtension on UserGoal {
  String get value {
    switch (this) {
      case UserGoal.gainWeight:
        return 'Gain Weight';

      case UserGoal.loseWeight:
        return 'Lose Weight';

      case UserGoal.getFitter:
        return 'Get Fitter';

      case UserGoal.gainMoreFlexible:
        return 'Gain More Flexible';

      case UserGoal.learnTheBasic:
        return 'Learn The Basic';
    }
  }
}
