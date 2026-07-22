import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final String area;
  final String country;

  const MealEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.area,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, image, area, country];
}
