import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {
  @JsonKey(name: "message")
  final String? message;

  LogoutResponse({this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return _$LogoutResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LogoutResponseToJson(this);
  }
}
