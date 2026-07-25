import '../../domain/entities/get_muscles_by_group_id_entity.dart';
import '../models/response/get_muscles_group_id_response.dart';

extension GetMuscleGroupIdMapper on MusclesID {
  GetMusclesByGroupIdEntity toEntity() {
    return GetMusclesByGroupIdEntity(id: id, name: name, image: image);
  }
}
