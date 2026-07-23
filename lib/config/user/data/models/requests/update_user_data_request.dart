import 'package:json_annotation/json_annotation.dart';

part 'update_user_data_request.g.dart';

@JsonSerializable()
class UpdateUserDataRequest {
  final String gender;
  final num height;
  final num weight;
  final num age;
  final String goal;
  final String activityLevel;

  UpdateUserDataRequest({
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    required this.goal,
    required this.activityLevel,
  });

  Map<String, dynamic> toJson() => _$UpdateUserDataRequestToJson(this);
}
