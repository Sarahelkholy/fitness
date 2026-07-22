import 'package:equatable/equatable.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class GetRandomExercisesSuccess extends HomeState {
  final RandomExercisesResponseEntity randomExercisesResponseEntity;

  const GetRandomExercisesSuccess({
    required this.randomExercisesResponseEntity,
  });

  @override
  List<Object> get props => [randomExercisesResponseEntity];
}

final class HomeFailure extends HomeState {
  final String errorMessage;

  const HomeFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
