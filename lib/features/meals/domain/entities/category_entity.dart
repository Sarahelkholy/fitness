import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final String description;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, image, description];
}
