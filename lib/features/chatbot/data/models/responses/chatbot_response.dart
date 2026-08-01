import 'package:json_annotation/json_annotation.dart';
import '../requests/chatbot_request.dart';

part 'chatbot_response.g.dart';

@JsonSerializable()
class ChatbotResponse {
  @JsonKey(name: "model")
  final String? model;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "message")
  final ChatMessageModel? message;
  @JsonKey(name: "done")
  final bool? done;

  ChatbotResponse({this.model, this.createdAt, this.message, this.done});

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatbotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatbotResponseToJson(this);
}
