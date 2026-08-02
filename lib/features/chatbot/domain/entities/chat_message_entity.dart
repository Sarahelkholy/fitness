import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String role;
  final String content;
  final DateTime timestamp;

  const ChatMessageEntity({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [role, content, timestamp];
}
