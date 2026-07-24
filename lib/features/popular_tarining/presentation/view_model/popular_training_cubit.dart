import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PopularTrainingCubit extends Cubit<PopularTrainingStates> {
  PopularTrainingCubit() : super(const PopularTrainingStates());

  Future<void> _loadPopularTraining() async {
    emit(state.copyWith(isLoading: true));
  }
}
