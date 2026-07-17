import '../../../../config/error_handling/result.dart';
import '../../../../config/social_auth/social_user.dart';
import '../../../../config/user/domain/entities/user_entity.dart';
import '../../data/models/requests/forget_password_request.dart';
import '../../data/models/requests/login_request.dart';
import '../../data/models/requests/register_request.dart';
import '../../data/models/requests/reset_password_request.dart';
import '../../data/models/requests/verify_reset_otp_request.dart';

abstract interface class AuthRepo {
  Future<Result<UserEntity>> login(LoginRequest loginRequest);

  Future<Result<UserEntity>> register(RegisterRequest registerRequest);

  Future<Result<String>> forgetPassword(
    ForgetPasswordRequest forgetPasswordRequest,
  );

  Future<Result<String>> verifyResetCode(
    VerifyResetOtpRequest verifyResetOtpRequest,
  );

  Future<Result<String>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  );

  Future<Result<SocialUser>> getGoogleUserData();

  Future<Result<SocialUser>> getFacebookUserData();
}
