import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/user/domain/entities/user_entity.dart';
import '../../../domain/entities/register_form_params.dart';

class RegisterFormState extends Equatable {
  final RegisterFormParams formData;

  final BaseState<UserEntity> updateUserState;

  const RegisterFormState({
    this.formData = const RegisterFormParams(),
    this.updateUserState = const BaseState(),
  });

  RegisterFormState copyWith({
    RegisterFormParams? formDataParam,
    BaseState<UserEntity>? updateUserStateParam,
  }) {
    return RegisterFormState(
      formData: formDataParam ?? formData,
      updateUserState: updateUserStateParam ?? updateUserState,
    );
  }

  @override
  List<Object?> get props => [formData, updateUserState];
}
