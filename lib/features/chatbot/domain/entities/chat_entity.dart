import 'package:equatable/equatable.dart';
import 'chat_message_entity.dart';

class ChatEntity extends Equatable {
  final String id;
  final String title;
  final String summary;
  final List<ChatMessageEntity> messages;
  final DateTime lastUpdated;

  const ChatEntity({
    required this.id,
    required this.title,
    required this.summary,
    required this.messages,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, title, summary, messages, lastUpdated];
}
