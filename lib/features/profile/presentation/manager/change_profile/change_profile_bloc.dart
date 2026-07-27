import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_profile_event.dart';
part 'change_profile_state.dart';

class ChangeProfileBloc extends Bloc<ChangeProfileEvent, ChangeProfileState> {
  ChangeProfileBloc() : super(ChangeProfileInitial()) {
    on<ChangeProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
