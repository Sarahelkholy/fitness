import 'package:equatable/equatable.dart';
import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';

class RandomExerciseEntity extends Equatable {
  final String? id;
  final String? name;
  final dynamic image;

  const RandomExerciseEntity({this.id, this.name, this.image});

  factory RandomExerciseEntity.fromMuscle(Muscles muscle) {
    return RandomExerciseEntity(
      id: muscle.id,
      name: muscle.name,
      image: muscle.image,
    );
  }

  Muscles toMuscles() {
    return Muscles(id: id, name: name, image: image);
  }

  @override
  List<Object?> get props => [id, name, image];
}
