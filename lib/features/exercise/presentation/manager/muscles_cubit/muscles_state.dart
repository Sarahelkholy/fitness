import 'package:equatable/equatable.dart';
import 'package:fitness/config/base_state/base_state.dart';
import '../../../domain/entities/get_all_muscles_group_entity.dart';
import '../../../domain/entities/get_muscles_by_group_id_entity.dart';

class MusclesState extends Equatable {
  final BaseState<List<GetAllMusclesGroupEntity>> musclesGroupsState;
  final BaseState<List<GetMusclesByGroupIdEntity>> workoutsState;
  final int selectedMuscleGroupIndex;

  const MusclesState({
    this.musclesGroupsState = const BaseState(),
    this.workoutsState = const BaseState(),
    this.selectedMuscleGroupIndex = 0,
  });

  MusclesState copyWith({
    BaseState<List<GetAllMusclesGroupEntity>>? musclesGroupsState,
    BaseState<List<GetMusclesByGroupIdEntity>>? workoutsState,
    int? selectedMuscleGroupIndex,
  }) {
    return MusclesState(
      musclesGroupsState: musclesGroupsState ?? this.musclesGroupsState,
      workoutsState: workoutsState ?? this.workoutsState,
      selectedMuscleGroupIndex:
          selectedMuscleGroupIndex ?? this.selectedMuscleGroupIndex,
    );
  }

  @override
  List<Object?> get props => [
    musclesGroupsState,
    workoutsState,
    selectedMuscleGroupIndex,
  ];
}
