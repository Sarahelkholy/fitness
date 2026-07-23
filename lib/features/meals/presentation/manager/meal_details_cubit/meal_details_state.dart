import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/meal_details_entity.dart';

class MealDetailsState extends Equatable {
  final BaseState<MealDetailsEntity> mealDetailsState;

  const MealDetailsState({this.mealDetailsState = const BaseState()});

  MealDetailsState copyWith({
    BaseState<MealDetailsEntity>? mealDetailsStateParam,
  }) {
    return MealDetailsState(
      mealDetailsState: mealDetailsStateParam ?? mealDetailsState,
    );
  }

  @override
  List<Object?> get props => [mealDetailsState];
}
