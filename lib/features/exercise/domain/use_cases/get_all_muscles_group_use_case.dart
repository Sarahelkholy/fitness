import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/get_all_muscles_group_entity.dart';
import '../repositories/home_repo.dart';

@injectable
class GetAllMusclesGroupUseCase {
  final HomeRepo _repo;
  const GetAllMusclesGroupUseCase(this._repo);
  Future<Result<List<GetAllMusclesGroupEntity>>> call({
    required String language,
  }) {
    return _repo.getAllMusclesGroup(language: language);
  }
}
