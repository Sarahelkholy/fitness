import 'package:json_annotation/json_annotation.dart';

part 'random_exercises_response.g.dart';

@JsonSerializable()
class RandomExercisesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalMuscles")
  final int? totalMuscles;
  @JsonKey(name: "muscles")
  final List<Muscles>? muscles;

  const RandomExercisesResponse({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory RandomExercisesResponse.fromJson(Map<String, dynamic> json) {
    return _$RandomExercisesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RandomExercisesResponseToJson(this);
  }
}

@JsonSerializable()
class Muscles {
  @JsonKey(name: "_id")
  final String? id; // Capitalized 'Id' updated to Dart naming conventions
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final dynamic image;

  const Muscles({this.id, this.name, this.image});

  factory Muscles.fromJson(Map<String, dynamic> json) {
    return _$MusclesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesToJson(this);
  }
}
