import 'package:equatable/equatable.dart';

enum UserGender { male, female }

enum UserGoal {
  gainWeight,
  loseWeight,
  getFitter,
  gainMoreFlexible,
  learnTheBasic,
}

enum ActivityLevel { level1, level2, level3, level4, level5 }

class RegisterFormParams extends Equatable {
  final UserGender? gender;
  final num? age;
  final num? weight;
  final num? height;
  final UserGoal? goal;
  final ActivityLevel? activityLevel;

  const RegisterFormParams({
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });

  RegisterFormParams copyWith({
    UserGender? gender,
    num? age,
    num? weight,
    num? height,
    UserGoal? goal,
    ActivityLevel? activityLevel,
  }) {
    return RegisterFormParams(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  @override
  List<Object?> get props => [gender, age, weight, height, goal, activityLevel];
}
