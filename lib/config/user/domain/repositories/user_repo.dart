import '../../data/models/requests/update_user_data_request.dart';
import '../entities/user_entity.dart';
import '../../../error_handling/result.dart';

abstract interface class UserRepo {
  Future<Result<UserEntity>> getUserData();
  Future<Result<UserEntity>> updateUserData(UpdateUserDataRequest request);
}
