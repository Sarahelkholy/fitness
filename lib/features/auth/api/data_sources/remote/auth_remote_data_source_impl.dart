import 'package:fitness/features/auth/data/models/responses/logout_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/error_handling/execute_api.dart';
import '../../../../../config/error_handling/result.dart';
import 'package:fitness/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import '../../../data/models/requests/forget_password_request.dart';
import '../../../data/models/requests/login_request.dart';
import '../../../data/models/requests/register_request.dart';
import '../../../data/models/requests/reset_password_request.dart';
import '../../../data/models/requests/verify_reset_otp_request.dart';
import '../../../data/models/responses/auth_response.dart';
import '../../auth_api_client/auth_api_client.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<AuthResponse>> login(LoginRequest loginRequest) {
    return executeApi(() async {
      return await _apiClient.login(loginRequest);
    });
  }

  @override
  Future<Result<AuthResponse>> register(RegisterRequest registerRequest) {
    return executeApi(() async {
      return await _apiClient.register(registerRequest);
    });
  }

  @override
  Future<Result<AuthResponse>> forgetPassword(ForgetPasswordRequest request) {
    return executeApi(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (request.email.toLowerCase() == 'email123@gmail.com') {
        return AuthResponse(message: 'Reset code sent successfully.');
      } else {
        throw Exception('Email not found');
      }
    });
  }

  @override
  Future<Result<AuthResponse>> verifyResetCode(VerifyResetOtpRequest request) {
    return executeApi(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (request.resetCode != '1234') {
        throw Exception('Invalid reset code');
      }

      return AuthResponse(message: 'OTP verified successfully.');
    });
  }

  @override
  Future<Result<AuthResponse>> resetPassword(ResetPasswordRequest request) {
    return executeApi(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (request.newPassword.length < 8) {
        throw Exception('Password is too short');
      }

      return AuthResponse(message: 'Password reset successfully.');
    });
  }

  @override
  Future<Result<LogoutResponse>> logout() {
    return executeApi(() async {
      return await _apiClient.logout();
    });
  }
}
