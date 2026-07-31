import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final T? data;

  const BaseState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.data,
  });

  BaseState<T> copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    T? data,
  }) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, isSuccess, data];
}
