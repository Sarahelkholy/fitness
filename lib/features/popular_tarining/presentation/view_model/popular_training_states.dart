import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/features/popular_tarining/domain/models/popular_training_item.dart';

class PopularTrainingStates extends BaseState<List<PopularTrainingItem>> {
  const PopularTrainingStates({
    super.isLoading = false,
    super.isSuccess = false,
    super.data = const [],
    super.errorMessage,
  });

  @override
  PopularTrainingStates copyWith({
    bool? isLoading,
    List<PopularTrainingItem>? data,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return PopularTrainingStates(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, data, errorMessage];
}
