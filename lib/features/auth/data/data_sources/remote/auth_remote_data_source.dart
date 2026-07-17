import '../../../../../config/error_handling/result.dart';
import '../../models/requests/forget_password_request.dart';
import '../../models/requests/reset_password_request.dart';
import '../../models/requests/verify_reset_otp_request.dart';
import '../../models/responses/auth_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<Result<AuthResponse>> forgetPassword(
    ForgetPasswordRequest forgetPasswordRequest,
  );

  Future<Result<AuthResponse>> verifyResetCode(
    VerifyResetOtpRequest verifyResetOtpRequest,
  );

  Future<Result<AuthResponse>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  );
}
