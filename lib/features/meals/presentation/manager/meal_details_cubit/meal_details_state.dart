import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/meal_details_entity.dart';

class MealDetailsState extends Equatable {
  final BaseState<MealDetailsEntity> mealDetailsState;
  final bool showYoutubePlayer;

  const MealDetailsState({
    this.mealDetailsState = const BaseState(),
    this.showYoutubePlayer = false,
  });

  MealDetailsState copyWith({
    BaseState<MealDetailsEntity>? mealDetailsStateParam,
    bool? showYoutubePlayerParam,
  }) {
    return MealDetailsState(
      mealDetailsState: mealDetailsStateParam ?? mealDetailsState,
      showYoutubePlayer: showYoutubePlayerParam ?? showYoutubePlayer,
    );
  }

  @override
  List<Object?> get props => [mealDetailsState, showYoutubePlayer];
}
