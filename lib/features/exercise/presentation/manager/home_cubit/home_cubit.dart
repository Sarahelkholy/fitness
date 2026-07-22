import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_random_exercises_use_case.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_events.dart';
import 'package:fitness/features/exercise/presentation/manager/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetRandomExercisesUseCase _getRandomExercisesUseCase;
  HomeCubit(this._getRandomExercisesUseCase) : super(HomeInitial());

  void doEvents(HomeEvents event) {
    switch (event) {
      case GetRandomExercises():
        _getRandomExercises(
          targetMuscleGroupId: event.targetMuscleGroupId,
          difficultyLevelId: event.difficultyLevelId,
          limit: event.limit,
        );
        break;
    }
  }

  Future<void> _getRandomExercises({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
    int limit = 3,
  }) async {
    emit(HomeLoading());

    final result = await _getRandomExercisesUseCase.call(
      targetMuscleGroupId: targetMuscleGroupId,
      difficultyLevelId: difficultyLevelId,
      limit: limit,
    );

    switch (result) {
      case Success<RandomExercisesResponseEntity>():
        emit(
          GetRandomExercisesSuccess(randomExercisesResponseEntity: result.data),
        );
        break;
      case Failure<RandomExercisesResponseEntity>():
        emit(HomeFailure(errorMessage: result.errorMessage));
        break;
    }
  }
}
