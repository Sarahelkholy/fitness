import 'package:equatable/equatable.dart';
import 'chat_message_entity.dart';

class ChatbotEntity extends Equatable {
  final String model;
  final ChatMessageEntity message;
  final bool done;

  const ChatbotEntity({
    required this.model,
    required this.message,
    required this.done,
  });

  @override
  List<Object?> get props => [model, message, done];
}
