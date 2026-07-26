import 'package:json_annotation/json_annotation.dart';

part 'get_all_muscles_group_response.g.dart';

@JsonSerializable()
class GetAllMusclesGroupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroup>? musclesGroup;

  GetAllMusclesGroupResponse ({
    this.message,
    this.musclesGroup,
  });

  factory GetAllMusclesGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAllMusclesGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllMusclesGroupResponseToJson(this);
  }
}

@JsonSerializable()
class MusclesGroup {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MusclesGroup ({
    this.id,
    this.name,
  });

  factory MusclesGroup.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupToJson(this);
  }
}


