import '../../domain/entities/user_entity.dart';
import '../models/responses/get_user_response/user_response.dart';

extension UserMapper on UserResponse {
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      email: email ?? "",
      gender: gender ?? "",
      photo: photo ?? "",
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      age: age ?? 22,
      weight: weight ?? 75,
      height: height ?? 175,
      activityLevel: activityLevel ?? "",
      goal: goal ?? "",
    );
  }
}
