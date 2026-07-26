import 'package:json_annotation/json_annotation.dart';

part 'get_muscles_group_id_response.g.dart';

@JsonSerializable()
class GetMusclesGroupIdResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalMuscles")
  final int? totalMuscles;
  @JsonKey(name: "muscles")
  final List<MusclesID>? muscles;

  GetMusclesGroupIdResponse ({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory GetMusclesGroupIdResponse.fromJson(Map<String, dynamic> json) {
    return _$GetMusclesGroupIdResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetMusclesGroupIdResponseToJson(this);
  }
}

@JsonSerializable()
class MusclesID {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  MusclesID ({
    this.id,
    this.name,
    this.image,
  });

  factory MusclesID.fromJson(Map<String, dynamic> json) {
    return _$MusclesIDFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesIDToJson(this);
  }
}


