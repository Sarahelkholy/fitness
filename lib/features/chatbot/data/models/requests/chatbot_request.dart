import 'package:json_annotation/json_annotation.dart';
import 'chat_message_model.dart';

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
