import '../../domain/entities/get_all_muscles_group_entity.dart';
import '../module/response/get_all_muscles_group_response.dart';

extension MusclesGroupMapper on MusclesGroup {
  GetAllMusclesGroupEntity toEntity() {
    return GetAllMusclesGroupEntity(
      id: id,
      name: name,
    );
  }
}