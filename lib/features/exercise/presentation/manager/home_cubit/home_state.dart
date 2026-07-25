import 'package:equatable/equatable.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_response_entity.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<CategoryEntity>? foodCategories;
  final RandomExercisesResponseEntity? randomExercisesResponseEntity;

  const HomeSuccess({this.foodCategories, this.randomExercisesResponseEntity});

  HomeSuccess copyWith({
    List<CategoryEntity>? foodCategories,
    RandomExercisesResponseEntity? randomExercisesResponseEntity,
  }) {
    return HomeSuccess(
      foodCategories: foodCategories ?? this.foodCategories,
      randomExercisesResponseEntity:
          randomExercisesResponseEntity ?? this.randomExercisesResponseEntity,
    );
  }

  @override
  List<Object?> get props => [foodCategories, randomExercisesResponseEntity];
}

final class HomeFailure extends HomeState {
  final String errorMessage;

  const HomeFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
