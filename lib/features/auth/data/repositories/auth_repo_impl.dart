import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../../../config/secure_cache/secure_cache/cache_keys.dart';
import '../../../../config/secure_cache/secure_cache/secure_cache.dart';
import '../../../../config/social_auth/social_auth_service.dart';
import '../../../../config/social_auth/social_user.dart';
import '../../../../config/user/data/mapper/user_mapper.dart';
import '../../../../config/user/domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_sources/remote/auth_remote_data_source.dart';
import '../models/requests/forget_password_request.dart';
import '../models/requests/login_request.dart';
import '../models/requests/register_request.dart';
import '../models/requests/reset_password_request.dart';
import '../models/requests/verify_reset_otp_request.dart';
import '../models/responses/auth_response.dart';

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
    var response = await _authRemoteDataSource.login(loginRequest);
    switch (response) {
      case Success<AuthResponse>():
        if (response.data.token != null) {
          await _secureCache.saveData(
            key: CacheKeys.token,
            value: response.data.token!,
          );
        }
        return Success(data: response.data.user!.toEntity());
      case Failure<AuthResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<UserEntity>> register(RegisterRequest registerRequest) async {
    final response = await _authRemoteDataSource.register(registerRequest);

    switch (response) {
      case Success<AuthResponse>():
        {
          if (response.data.token != null) {
            await _secureCache.saveData(
              key: CacheKeys.token,
              value: response.data.token!,
            );
          }

          final entity = response.data.user!.toEntity();

          return Success(data: entity);
        }
      case Failure<AuthResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<String>> forgetPassword(
    ForgetPasswordRequest forgetPasswordRequest,
  ) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  ) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> verifyResetCode(
    VerifyResetOtpRequest verifyResetOtpRequest,
  ) {
    // TODO: implement verifyResetCode
    throw UnimplementedError();
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
