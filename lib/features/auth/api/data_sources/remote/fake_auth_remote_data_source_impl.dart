// import 'dart:async';

// import 'package:fitness/config/error_handling/execute_api.dart';
// import 'package:fitness/config/error_handling/result.dart';
// import 'package:fitness/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
// import 'package:fitness/features/auth/data/models/requests/forget_password_request.dart';
// import 'package:fitness/features/auth/data/models/requests/login_request.dart';
// import 'package:fitness/features/auth/data/models/requests/register_request.dart';
// import 'package:fitness/features/auth/data/models/requests/reset_password_request.dart';
// import 'package:fitness/features/auth/data/models/requests/verify_reset_otp_request.dart';
// import 'package:fitness/features/auth/data/models/responses/auth_response.dart';
// import 'package:injectable/injectable.dart';

// @Injectable(as: AuthRemoteDataSource)
// class FakeAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   const FakeAuthRemoteDataSourceImpl();
//   @override
//   Future<Result<AuthResponse>> forgetPassword(ForgetPasswordRequest request) {
//     return executeApi(() async {
//       await Future.delayed(const Duration(seconds: 1));

//       if (request.email == 'notfound@test.com') {
//         throw Exception('Email not found');
//       }

//       return AuthResponse(message: 'Reset code sent successfully.');
//     });
//   }

//   @override
//   Future<Result<AuthResponse>> verifyResetCode(VerifyResetOtpRequest request) {
//     return executeApi(() async {
//       await Future.delayed(const Duration(seconds: 1));

//       if (request.resetCode != '1234') {
//         throw Exception('Invalid reset code');
//       }

//       return AuthResponse(message: 'OTP verified successfully.');
//     });
//   }

//   @override
//   Future<Result<AuthResponse>> resetPassword(ResetPasswordRequest request) {
//     return executeApi(() async {
//       await Future.delayed(const Duration(seconds: 1));

//       if (request.newPassword.length < 8) {
//         throw Exception('Password is too short');
//       }

//       return AuthResponse(message: 'Password reset successfully.');
//     });
//   }

//   @override
//   Future<Result<AuthResponse>> login(LoginRequest loginRequest) {
//     // TODO: implement login
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<AuthResponse>> register(RegisterRequest registerRequest) {
//     // TODO: implement register
//     throw UnimplementedError();
//   }
// }
