import 'package:equatable/equatable.dart';

class GetMusclesByGroupIdEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;
  const GetMusclesByGroupIdEntity({this.id, this.name, this.image});
  @override
  List<Object?> get props => [id, name, image];
}
