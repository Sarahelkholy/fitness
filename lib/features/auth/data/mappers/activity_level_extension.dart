import '../../domain/entities/register_form_data.dart';

extension ActivityLevelExtension on ActivityLevel {
  String get value {
    switch (this) {
      case ActivityLevel.level1:
        return 'level1';

      case ActivityLevel.level2:
        return 'level2';

      case ActivityLevel.level3:
        return 'level3';

      case ActivityLevel.level4:
        return 'level4';

      case ActivityLevel.level5:
        return 'level5';
    }
  }
}
