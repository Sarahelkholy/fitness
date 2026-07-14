import '../../domain/entities/user_entity.dart';
import '../models/responses/get_user_response/user_response.dart';

extension UserMapper on UserResponse {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      photo: photo,
      createdAt: createdAt,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
    );
  }
}
