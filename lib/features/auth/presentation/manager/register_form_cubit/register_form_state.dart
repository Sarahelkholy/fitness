import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/user/domain/entities/user_entity.dart';
import '../../../domain/entities/register_form_data.dart';

class RegisterFormState extends Equatable {
  final RegisterFormData formData;

  final BaseState<UserEntity> updateUserState;

  const RegisterFormState({
    this.formData = const RegisterFormData(),
    this.updateUserState = const BaseState(),
  });

  RegisterFormState copyWith({
    RegisterFormData? formDataParam,
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
