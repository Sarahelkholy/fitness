import 'package:fitness/config/user/data/models/responses/get_user_response/get_user_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response.g.dart';

@JsonSerializable()
class EditProfileResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final GetUserDataResponse? user;

  EditProfileResponse({this.message, this.user});

  EditProfileResponse copyWith({String? message, GetUserDataResponse? user}) =>
      EditProfileResponse(
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseToJson(this);
}
