import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/auth/domain/entities/logout_response_entity.dart';
import 'package:fitness/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final AuthRepo _repo;

  LogoutUseCase(this._repo);

  Future<Result<LogoutResponseEntity>> call() {
    return _repo.logout();
  }
}
