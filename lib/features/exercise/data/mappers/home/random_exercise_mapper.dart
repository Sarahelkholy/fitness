import 'package:fitness/features/exercise/data/models/home/random_exercises_response.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_entity.dart';

extension MusclesMapper on Muscles {
  RandomExerciseEntity toEntity() {
    return RandomExerciseEntity(id: id, name: name, image: image);
  }
}
