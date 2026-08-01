import 'package:equatable/equatable.dart';

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

class ChatMessageEntity extends Equatable {
  final String role;
  final String content;

  const ChatMessageEntity({required this.role, required this.content});

  @override
  List<Object?> get props => [role, content];
}
