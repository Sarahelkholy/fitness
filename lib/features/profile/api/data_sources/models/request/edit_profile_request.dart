import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "goal")
  final String? goal;
  @JsonKey(name: "weight")
  final double? weight;
  @JsonKey(name: "height")
  final double? height;
  @JsonKey(name: "activityLevel")
  final String? activityLevel;
  @JsonKey(name: "gender")
  final String? gender;

  EditProfileRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.goal,
    this.weight,
    this.height,
    this.activityLevel,
    this.gender,
  });

  EditProfileRequest copyWith({
    String? firstName,
    String? lastName,
    String? goal,
    double? weight,
    double? height,
    String? activityLevel,
    String? gender,
    String? birthDate,
    String? country,
    String? city,
    String? phone,
  }) => EditProfileRequest(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
  );

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}
