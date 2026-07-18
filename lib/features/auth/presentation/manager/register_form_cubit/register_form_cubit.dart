import 'package:injectable/injectable.dart';

import '../../../../../config/base_cubit/base_cubit.dart';
import '../../../../../config/base_cubit/base_event.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/di/di.dart';
import '../../../../../config/route_manager/routes.dart';
import '../../../../../config/user/manager/user_cubit.dart';
import '../../../../../config/user/manager/user_events.dart';
import '../../../../../config/error_handling/result.dart';
import '../../../../../config/user/data/models/requests/update_user_data_request.dart';
import '../../../../../config/user/domain/use_cases/update_user_data_use_case.dart';

import '../../../data/mappers/activity_level_extension.dart';
import '../../../data/mappers/user_gender_extension.dart';
import '../../../data/mappers/user_goal_mapper.dart';
import 'register_form_event.dart';
import 'register_form_state.dart';

@injectable
class RegisterFormCubit extends BaseCubit<RegisterFormState, BaseEvent> {
  final UpdateUserDataUseCase _updateUserDataUseCase;

  RegisterFormCubit(this._updateUserDataUseCase)
    : super(const RegisterFormState());

  void doEvents(RegisterFormEvents event) {
    switch (event) {
      case PickGenderEvent():
        _pickGender(event);

      case PickAgeEvent():
        _pickAge(event);

      case PickWeightEvent():
        _pickWeight(event);

      case PickHeightEvent():
        _pickHeight(event);

      case PickGoalEvent():
        _pickGoal(event);

      case PickActivityLevelEvent():
        _pickActivityLevel(event);

      case SubmitRegisterFormEvent():
        _submit();
    }
  }

  void _pickGender(PickGenderEvent event) {
    emit(
      state.copyWith(
        formDataParam: state.formData.copyWith(gender: event.gender),
      ),
    );
  }

  void _pickAge(PickAgeEvent event) {
    emit(
      state.copyWith(formDataParam: state.formData.copyWith(age: event.age)),
    );
  }

  void _pickWeight(PickWeightEvent event) {
    emit(
      state.copyWith(
        formDataParam: state.formData.copyWith(weight: event.weight),
      ),
    );
  }

  void _pickHeight(PickHeightEvent event) {
    emit(
      state.copyWith(
        formDataParam: state.formData.copyWith(height: event.height),
      ),
    );
  }

  void _pickGoal(PickGoalEvent event) {
    emit(
      state.copyWith(formDataParam: state.formData.copyWith(goal: event.goal)),
    );
  }

  void _pickActivityLevel(PickActivityLevelEvent event) {
    emit(
      state.copyWith(
        formDataParam: state.formData.copyWith(
          activityLevel: event.activityLevel,
        ),
      ),
    );
  }

  Future<void> _submit() async {
    emit(
      state.copyWith(updateUserStateParam: const BaseState(isLoading: true)),
    );

    final form = state.formData;

    final result = await _updateUserDataUseCase.call(
      UpdateUserDataRequest(
        gender: form.gender!.value,
        height: form.height!,
        weight: form.weight!,
        age: form.age!,
        goal: form.goal!.value,
        activityLevel: form.activityLevel!.value,
      ),
    );

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            updateUserStateParam: BaseState(isSuccess: true, data: result.data),
          ),
        );

        getIt<UserCubit>().doEvent(SetUserDataEvent(user: result.data));
        emitEvent(
          const NavigationEvent(
            routeName: Routes.homeRoute,
            type: NavigationType.pushReplacementAndRemoveUntil,
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            updateUserStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );

        emitEvent(DisplayErrorEvent(errorMsg: result.errorMessage));
    }
  }
}
