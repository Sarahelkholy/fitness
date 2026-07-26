import 'package:equatable/equatable.dart';

class GetAllMusclesGroupEntity extends Equatable {
  final String? id;
  final String? name;

  const GetAllMusclesGroupEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
