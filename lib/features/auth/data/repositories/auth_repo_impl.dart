import 'package:fitness/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:fitness/config/social_auth/social_auth_service.dart';
import 'package:fitness/config/social_auth/social_user.dart';
import 'package:fitness/features/auth/data/models/responses/auth_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../config/user/domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import 'package:fitness/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import '../models/requests/forget_password_request.dart';
import '../models/requests/login_request.dart';
import '../models/requests/register_request.dart';
import '../models/requests/reset_password_request.dart';
import '../models/requests/verify_reset_otp_request.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final SecureCache _secureCache;
  final SocialAuthService _socialAuthService;

  AuthRepoImpl(
    this._authRemoteDataSource,
    this._secureCache,
    this._socialAuthService,
  );

  @override
  Future<Result<UserEntity>> login(LoginRequest loginRequest) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity>> register(RegisterRequest registerRequest) async {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> forgetPassword(
    ForgetPasswordRequest forgetPasswordRequest,
  ) async {
    final response = await _authRemoteDataSource.forgetPassword(
      forgetPasswordRequest,
    );

    switch (response) {
      case Success<AuthResponse>():
        return Success(data: response.data.message ?? '');

      case Failure<AuthResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<String>> verifyResetCode(
    VerifyResetOtpRequest verifyResetOtpRequest,
  ) async {
    final response = await _authRemoteDataSource.verifyResetCode(
      verifyResetOtpRequest,
    );

    switch (response) {
      case Success<AuthResponse>():
        return Success(data: response.data.message ?? '');

      case Failure<AuthResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<String>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  ) async {
    final response = await _authRemoteDataSource.resetPassword(
      resetPasswordRequest,
    );

    switch (response) {
      case Success<AuthResponse>():
        return Success(data: response.data.message ?? '');

      case Failure<AuthResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<SocialUser>> getGoogleUserData() async {
    var response = await _socialAuthService.getGoogleUserData();
    switch (response) {
      case Success<SocialUser>():
        return Success(data: response.data);
      case Failure<SocialUser>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<SocialUser>> getFacebookUserData() async {
    var response = await _socialAuthService.getFacebookUserData();
    switch (response) {
      case Success<SocialUser>():
        return Success(data: response.data);
      case Failure<SocialUser>():
        return Failure(errorMessage: response.errorMessage);
    }
  }



}
