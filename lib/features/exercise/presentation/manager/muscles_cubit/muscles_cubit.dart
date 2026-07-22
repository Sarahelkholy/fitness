import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/get_all_muscles_group_entity.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_all_muscles_group_use_case.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_event.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_cubit/base_cubit.dart';
import '../../../../../config/base_cubit/base_event.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/route_manager/routes.dart';
import '../../../domain/entities/get_muscles_by_group_id_entity.dart';
import '../../../domain/use_cases/get_muscles_group_id_use_case.dart';

@injectable
class MusclesCubit extends BaseCubit<MusclesState, BaseEvent>{
  MusclesCubit(this._getAllMusclesGroupUseCase,this._getMusclesGroupIdUseCase): super(MusclesState());
  final GetAllMusclesGroupUseCase _getAllMusclesGroupUseCase;
  final GetMusclesGroupIdUseCase _getMusclesGroupIdUseCase;

  ///? ================== function Event =========================
  void doIntent(MusclesEvent event) {
    switch (event) {

      case GetAllMuscles():
       _getAllMuscles(language: event.language,);
      case GetMusclesId():
        _getMusclesId(language: event.language ,muscleGroupId: event.muscleGroupId);
    }
  }

  ///? ================= Get All Muscles ====================
  Future<void> _getAllMuscles({required String language})async{
    emit(state.copyWith(getAllMusclesGroup: const BaseState(isLoading: true)));
    final result = await _getAllMusclesGroupUseCase.call(language: language);
    switch(result){

      case Success<List<GetAllMusclesGroupEntity>>():
        emit(
          state.copyWith(
            getAllMusclesGroup: BaseState(data: result.data  , isSuccess: true),
          ),
        );
        emitEvent(
          const NavigationEvent(
            routeName: Routes.bottomNavBarRoute,
            type: NavigationType.pushReplacementAndRemoveUntil,
          ),
        );

      case Failure<List<GetAllMusclesGroupEntity>>():
        emit(
          state.copyWith(
            getAllMusclesGroup: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }

  ///? ================ Get All Muscles ID  ====================
  Future<void> _getMusclesId({required String language, required String muscleGroupId})async{
    emit(state.copyWith(getMusclesByGroupId: const BaseState(isLoading: true)));
    final result = await _getMusclesGroupIdUseCase.call(language: language, muscleGroupId: muscleGroupId);
    switch(result){
      case Success<List<GetMusclesByGroupIdEntity>>():
        emit(
          state.copyWith(
            getMusclesByGroupId: BaseState(data: result.data, isSuccess: true),
          ),
        );
        emitEvent(
          const NavigationEvent(
            routeName: Routes.bottomNavBarRoute,
            type: NavigationType.pushReplacementAndRemoveUntil,
          ),
        );

      case Failure<List<GetMusclesByGroupIdEntity>>():
        emit(
          state.copyWith(
            getMusclesByGroupId: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }
}