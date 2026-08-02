import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessageModel {
  @JsonKey(name: "role")
  final String role;
  @JsonKey(name: "content")
  final String content;
  @JsonKey(name: "timestamp")
  final DateTime? timestamp;

  ChatMessageModel({required this.role, required this.content, this.timestamp});

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);

  factory ChatMessageModel.fromFirestore(Map<String, dynamic> json) {
    return ChatMessageModel(
      role: json['role'] as String,
      content: json['content'] as String,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
