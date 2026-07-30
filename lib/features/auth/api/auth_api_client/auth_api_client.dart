import 'package:dio/dio.dart';
import 'package:fitness/features/auth/data/models/responses/logout_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/values/api_end_points.dart';
import '../../../../core/values/api_strings.dart';
import '../../data/models/requests/forget_password_request.dart';
import '../../data/models/requests/login_request.dart';
import '../../data/models/requests/register_request.dart';
import '../../data/models/requests/reset_password_request.dart';
import '../../data/models/requests/verify_reset_otp_request.dart';
import '../../data/models/responses/auth_response.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApiEndPoints.login)
  @Extra({ApiStrings.requireAuth: false})
  Future<AuthResponse> login(@Body() LoginRequest loginRequest);

  @POST(ApiEndPoints.register)
  @Extra({ApiStrings.requireAuth: false})
  Future<AuthResponse> register(@Body() RegisterRequest registerRequest);

  @GET(ApiEndPoints.logout)
  Future<LogoutResponse> logout();

  @POST(ApiEndPoints.forgetPassword)
  @Extra({ApiStrings.requireAuth: false})
  Future<AuthResponse> forgetPassword(
    @Body() ForgetPasswordRequest forgetPasswordRequest,
  );

  @POST(ApiEndPoints.verifyRestOtp)
  @Extra({ApiStrings.requireAuth: false})
  Future<AuthResponse> verifyResetCode(
    @Body() VerifyResetOtpRequest verifyResetOtpRequest,
  );

  @POST(ApiEndPoints.resetPassword)
  @Extra({ApiStrings.requireAuth: false})
  Future<AuthResponse> resetPassword(
    @Body() ResetPasswordRequest resetPasswordRequest,
  );
}
