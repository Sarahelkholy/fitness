import 'package:injectable/injectable.dart';

import '../../../error_handling/result.dart';
import '../../data/models/requests/update_user_data_request.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repo.dart';

@injectable
class UpdateUserDataUseCase {
  final UserRepo _repo;

  const UpdateUserDataUseCase(this._repo);

  Future<Result<UserEntity>> call(UpdateUserDataRequest request) {
    return _repo.updateUserData(request);
  }
}
