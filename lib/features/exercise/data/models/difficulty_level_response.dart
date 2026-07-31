// To parse this JSON data, do
//
//     final difficultyLevelResponse = difficultyLevelResponseFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'difficulty_level_response.g.dart';

DifficultyLevelResponse difficultyLevelResponseFromJson(String str) =>
    DifficultyLevelResponse.fromJson(json.decode(str));

String difficultyLevelResponseToJson(DifficultyLevelResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class DifficultyLevelResponse {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "totalLevels")
  int? totalLevels;

  @JsonKey(name: "difficulty_levels")
  List<DifficultyLevelDto>? difficultyLevels;

  DifficultyLevelResponse({
    this.message,
    this.totalLevels,
    this.difficultyLevels,
  });

  factory DifficultyLevelResponse.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyLevelResponseToJson(this);
}

@JsonSerializable()
class DifficultyLevelDto {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  DifficultyLevelDto({this.id, this.name});

  factory DifficultyLevelDto.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyLevelDtoToJson(this);
}
