import 'package:fitness/config/base_state/base_state.dart';
import '../../../domain/entities/get_all_muscles_group_entity.dart';
import '../../../domain/entities/get_muscles_by_group_id_entity.dart';

class MusclesState {
  MusclesState({this.getAllMusclesGroup,this.getMusclesByGroupId});

  ///? ================= Get All Muscles ====================
  BaseState<List<GetAllMusclesGroupEntity>>? getAllMusclesGroup = const BaseState();

  ///? ================= Get Muscles Group id ====================
  BaseState<List<GetMusclesByGroupIdEntity>>? getMusclesByGroupId = const BaseState();

  MusclesState copyWith({
    BaseState<List<GetAllMusclesGroupEntity>>? getAllMusclesGroup,
    BaseState<List<GetMusclesByGroupIdEntity>>? getMusclesByGroupId,
  }) {
    return MusclesState(
      getAllMusclesGroup: getAllMusclesGroup ?? this.getAllMusclesGroup,
      getMusclesByGroupId: getMusclesByGroupId ?? this.getMusclesByGroupId,
    );
  }
}
