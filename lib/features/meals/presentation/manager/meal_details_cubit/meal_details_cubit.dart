import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/error_handling/result.dart';
import '../../../domain/use_cases/get_meal_details_use_case.dart';
import 'meal_details_event.dart';
import 'meal_details_state.dart';

@injectable
class MealDetailsCubit extends BaseCubit<MealDetailsState, BaseEvent> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  MealDetailsCubit(this._getMealDetailsUseCase)
    : super(const MealDetailsState());

  void doEvents(MealDetailsEvents event) {
    switch (event) {
      case GetMealDetailsEvent():
        _getMealDetails(event.mealId);
      case PlayVideoEvent():
        emit(state.copyWith(showYoutubePlayerParam: true));
    }
  }

  Future<void> _getMealDetails(String mealId) async {
    emit(
      state.copyWith(
        mealDetailsStateParam: const BaseState(isLoading: true),
        showYoutubePlayerParam: false,
      ),
    );

    final result = await _getMealDetailsUseCase.call(mealId);

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            mealDetailsStateParam: BaseState(
              isSuccess: true,
              data: result.data,
            ),
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            mealDetailsStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }
}
