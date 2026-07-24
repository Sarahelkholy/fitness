import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'exercise_dto.dart';

part 'exercise_response.g.dart';

ExerciseResponse exerciseResponseFromJson(String str) =>
    ExerciseResponse.fromJson(json.decode(str));

String exerciseResponseToJson(ExerciseResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ExerciseResponse {
  @JsonKey(name: "message") String? message;
  @JsonKey(name: "totalExercises") int? totalExercises;
  @JsonKey(name: "totalPages") int? totalPages;
  @JsonKey(name: "currentPage") int? currentPage;
  @JsonKey(name: "exercises") List<ExerciseDto>? exercises;

  ExerciseResponse(
      {this.message, this.totalExercises, this.totalPages, this.currentPage, this.exercises});

  factory ExerciseResponse.fromJson(Map<String, dynamic> json)=>
      _$ExerciseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseResponseToJson(this);
}
