import 'package:fitness/features/exercise/data/models/response/get_all_muscles_group_response.dart';

import '../../domain/entities/get_all_muscles_group_entity.dart';

extension MusclesGroupMapper on MusclesGroup {
  GetAllMusclesGroupEntity toEntity() {
    return GetAllMusclesGroupEntity(id: id, name: name);
  }
}
