import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/user/domain/entities/user_entity.dart';

class RegisterState extends Equatable {
  final BaseState<UserEntity> registerState;
  final bool isSubmitted;

  const RegisterState({
    this.registerState = const BaseState(),
    this.isSubmitted = false,
  });

  RegisterState copyWith({
    BaseState<UserEntity>? registerStateParam,
    bool? isSubmittedParam,
  }) {
    return RegisterState(
      registerState: registerStateParam ?? registerState,
      isSubmitted: isSubmittedParam ?? isSubmitted,
    );
  }

  @override
  List<Object?> get props => [registerState, isSubmitted];
}
