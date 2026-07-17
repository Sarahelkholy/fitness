import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/requests/reset_password_request.dart';
import '../repositories/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _repo;

  const ResetPasswordUseCase(this._repo);

  Future<Result<String>> call(ResetPasswordRequest request) {
    return _repo.resetPassword(request);
  }
}
