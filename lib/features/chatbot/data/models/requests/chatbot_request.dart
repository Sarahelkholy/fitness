import 'package:json_annotation/json_annotation.dart';

part 'chatbot_request.g.dart';

@JsonSerializable()
class ChatbotRequest {
  @JsonKey(name: "model")
  final String model;
  @JsonKey(name: "messages")
  final List<ChatMessageModel> messages;
  @JsonKey(name: "stream")
  final bool stream;

  ChatbotRequest({
    required this.model,
    required this.messages,
    this.stream = false,
  });

  factory ChatbotRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatbotRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChatbotRequestToJson(this);
}

@JsonSerializable()
class ChatMessageModel {
  @JsonKey(name: "role")
  final String role;
  @JsonKey(name: "content")
  final String content;

  ChatMessageModel({required this.role, required this.content});

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
