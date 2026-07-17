import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/requests/verify_reset_otp_request.dart';
import '../repositories/auth_repo.dart';

@injectable
class VerifyResetOtpUseCase {
  final AuthRepo _repo;

  const VerifyResetOtpUseCase(this._repo);

  Future<Result<String>> call(VerifyResetOtpRequest request) {
    return _repo.verifyResetCode(request);
  }
}
