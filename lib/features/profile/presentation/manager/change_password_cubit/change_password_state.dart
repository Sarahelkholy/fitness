import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/change_password_request_entity.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordEntity> changeOldPasswordState;
  const ChangePasswordState({this.changeOldPasswordState = const BaseState()});
  ChangePasswordState copyWith({
    BaseState<ChangePasswordEntity>? changePasswordStateParam,
  }) {
    return ChangePasswordState(
      changeOldPasswordState:
          changePasswordStateParam ?? changeOldPasswordState,
    );
  }

  @override
  List<Object?> get props => [changeOldPasswordState];
}
