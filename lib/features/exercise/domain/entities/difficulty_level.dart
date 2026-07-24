import 'package:equatable/equatable.dart';

class DifficultyLevel extends Equatable {
  final String? id;
  final String? name;

  const DifficultyLevel({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
