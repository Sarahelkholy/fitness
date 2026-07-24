import '../../domain/entities/difficulty_level.dart' as entity;
import '../models/difficulty_level_response.dart' as model;

extension DifficultyLevelMapper on model.DifficultyLevelDto {
  entity.DifficultyLevel toEntity() {
    return entity.DifficultyLevel(
      id: id,
      name: name,
    );
  }
}
