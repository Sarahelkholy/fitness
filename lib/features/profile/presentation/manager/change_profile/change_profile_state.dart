part of 'change_profile_bloc.dart';

sealed class ChangeProfileState extends Equatable {
  const ChangeProfileState();

  @override
  List<Object> get props => [];
}

final class ChangeProfileInitial extends ChangeProfileState {}
