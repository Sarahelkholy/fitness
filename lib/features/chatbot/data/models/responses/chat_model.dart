import '../requests/chat_message_model.dart';

class ChatModel {
  final String id;
  final String title;
  final String summary;
  final List<ChatMessageModel> messages;
  final DateTime lastUpdated;

  ChatModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.messages,
    required this.lastUpdated,
  });

  factory ChatModel.fromFirestore(Map<String, dynamic> json, String id) {
    return ChatModel(
      id: id,
      title: json['title'] as String? ?? "",
      summary: json['summary'] as String? ?? "",
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ChatMessageModel.fromFirestore(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'summary': summary,
      'messages': messages.map((e) => e.toFirestore()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
