import 'package:fitness/features/exercise/domain/use_cases/get_difficulty_levels_use_case.dart';
import 'package:fitness/features/exercise/domain/use_cases/get_exercises_use_case.dart';
import 'package:fitness/features/popular_tarining/domain/use_cases/get_random_exercise_use_case.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PopularTrainingCubit extends Cubit<PopularTrainingStates> {
  final GetRandomExerciseUseCase _getRandomExerciseUseCase;
  final GetExercisesUseCase _getExercisesUseCase;
  final GetDifficultyLevelsUseCase _getDifficultyLevelsUseCase;
  PopularTrainingCubit(
    this._getRandomExerciseUseCase,
    this._getExercisesUseCase,
    this._getDifficultyLevelsUseCase,
  ) : super(const PopularTrainingStates());

  void doIntents(PopularTrainingIntents intent) {
    switch (intent) {
      case LoadPopularTrainingIntent():
        _loadPopularTraining();
        break;
    }
  }

  Future<void> _loadPopularTraining() async {
    emit(state.copyWith(isLoading: true));
  }
}
