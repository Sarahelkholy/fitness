import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/get_all_muscles_group_entity.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_all_muscles_group_use_case.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_event.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_cubit/base_cubit.dart';
import '../../../../../config/base_cubit/base_event.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/use_cases/get_muscles_group_id_use_case.dart';

@injectable
class MusclesCubit extends BaseCubit<MusclesState, BaseEvent> {
  final GetAllMusclesGroupUseCase _getAllMusclesGroupUseCase;
  final GetMusclesGroupIdUseCase _getMusclesGroupIdUseCase;

  MusclesCubit(this._getAllMusclesGroupUseCase, this._getMusclesGroupIdUseCase)
    : super(const MusclesState());

  void doEvents(MusclesEvent event) {
    switch (event) {
      case GetAllMusclesEvent():
        _getAllMuscles(language: event.language);
      case GetWorkoutsByMuscleGroupIdEvent():
        _getWorkoutsByMuscleGroupId(
          language: event.language,
          muscleGroupId: event.muscleGroupId,
          index: event.index,
        );
    }
  }

  Future<void> _getAllMuscles({required String language}) async {
    emit(
      state.copyWith(
        musclesGroupsState: const BaseState(isLoading: true),
        selectedMuscleGroupIndex: 0,
      ),
    );

    final result = await _getAllMusclesGroupUseCase.call(language: language);

    switch (result) {
      case Success<List<GetAllMusclesGroupEntity>>():
        emit(
          state.copyWith(
            musclesGroupsState: BaseState(data: result.data, isSuccess: true),
          ),
        );
        if (result.data.isNotEmpty) {
          final index = (state.selectedMuscleGroupIndex < result.data.length)
              ? state.selectedMuscleGroupIndex
              : 0;
          final muscleGroupId = result.data[index].id ?? "";
          _getWorkoutsByMuscleGroupId(
            language: language,
            muscleGroupId: muscleGroupId,
            index: index,
          );
        }
      case Failure<List<GetAllMusclesGroupEntity>>():
        emit(
          state.copyWith(
            musclesGroupsState: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  Future<void> _getWorkoutsByMuscleGroupId({
    required String language,
    required String muscleGroupId,
    required int index,
  }) async {
    emit(
      state.copyWith(
        workoutsState: const BaseState(isLoading: true),
        selectedMuscleGroupIndex: index,
      ),
    );

    final result = await _getMusclesGroupIdUseCase.call(
      language: language,
      muscleGroupId: muscleGroupId,
    );

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            workoutsState: BaseState(data: result.data, isSuccess: true),
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            workoutsState: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }
}
