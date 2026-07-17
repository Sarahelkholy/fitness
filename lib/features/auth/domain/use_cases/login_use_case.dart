import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../config/user/domain/entities/user_entity.dart';
import '../../data/models/requests/login_request.dart';
import '../repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _repo;

  const LoginUseCase(this._repo);

  Future<Result<UserEntity>> call(LoginRequest loginRequest) {
    return _repo.login(loginRequest);
  }
}
