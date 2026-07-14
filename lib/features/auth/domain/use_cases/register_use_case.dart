import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../config/user/domain/entities/user_entity.dart';
import '../../data/models/requests/register_request.dart';
import '../repositories/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _repo;

  const RegisterUseCase(this._repo);

  Future<Result<UserEntity>> call(RegisterRequest registerRequest) {
    return _repo.register(registerRequest);
  }
}
