import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/get_muscles_by_group_id_entity.dart';
import '../repositories/home_repo.dart';

@injectable
class GetMusclesGroupIdUseCase {
  final HomeRepo _repo;
  const GetMusclesGroupIdUseCase(this._repo);

  ///? ================= Get Muscle Using id ===================
  Future<Result<List<GetMusclesByGroupIdEntity>>> call({
    required String language,
    required String muscleGroupId,
  }) {
    return _repo.getMusclesByGroupId(
      language: language,
      muscleGroupId: muscleGroupId,
    );
  }
}
