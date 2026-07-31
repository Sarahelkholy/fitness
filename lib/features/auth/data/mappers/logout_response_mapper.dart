import 'package:fitness/features/auth/data/models/responses/logout_response.dart';
import 'package:fitness/features/auth/domain/entities/logout_response_entity.dart';

extension LogoutResponseMapper on LogoutResponse {
  LogoutResponseEntity toEntity() {
    return LogoutResponseEntity(message: message);
  }
}
