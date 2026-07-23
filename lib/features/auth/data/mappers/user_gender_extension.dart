import '../../domain/entities/register_form_data.dart';

extension UserGenderExtension on UserGender {
  String get value {
    switch (this) {
      case UserGender.male:
        return 'male';

      case UserGender.female:
        return 'female';
    }
  }
}
