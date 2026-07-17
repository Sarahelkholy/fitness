import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_otp_request.g.dart';

@JsonSerializable()
class VerifyResetOtpRequest {
  final String resetCode;

  VerifyResetOtpRequest({required this.resetCode});

  Map<String, dynamic> toJson() => _$VerifyResetOtpRequestToJson(this);
}
