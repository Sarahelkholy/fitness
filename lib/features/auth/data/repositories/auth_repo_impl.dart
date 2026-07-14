import 'package:fitness/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../config/user/data/mapper/user_mapper.dart';
import '../../../../config/user/domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import 'package:fitness/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
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

  AuthRepoImpl(this._authRemoteDataSource, this._secureCache);

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
}
