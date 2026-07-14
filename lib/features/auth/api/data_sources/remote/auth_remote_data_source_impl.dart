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
  Future<Result<AuthResponse>> forgetPassword(
    ForgetPasswordRequest forgetPasswordRequest,
  ) {
    return executeApi(() async {
      return await _apiClient.forgetPassword(forgetPasswordRequest);
    });
  }

  @override
  Future<Result<AuthResponse>> verifyResetCode(
    VerifyResetOtpRequest verifyResetOtpRequest,
  ) {
    return executeApi(() async {
      return await _apiClient.verifyResetCode(verifyResetOtpRequest);
    });
  }

  @override
  Future<Result<AuthResponse>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  ) {
    return executeApi(() async {
      return await _apiClient.resetPassword(resetPasswordRequest);
    });
  }
}
