import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.goal,
    required this.photo,
    required this.id,
    required this.createdAt,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final num age;
  final num weight;
  final num height;
  final String activityLevel;
  final String goal;
  final String photo;
  final String id;
  final DateTime createdAt;

  @override
  List<Object> get props =>
      [
    firstName,
    lastName,
    email,
    gender,
    age,
    weight,
    height,
    activityLevel,
    goal,
    photo,
    id,
    createdAt,
  ];
}
