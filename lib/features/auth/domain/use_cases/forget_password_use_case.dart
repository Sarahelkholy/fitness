import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/requests/forget_password_request.dart';
import '../repositories/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _repo;

  const ForgetPasswordUseCase(this._repo);

  Future<Result<String>> call(ForgetPasswordRequest request) {
    return _repo.forgetPassword(request);
  }
}
