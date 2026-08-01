import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String role;
  final String content;

  const ChatMessageEntity({required this.role, required this.content});

  @override
  List<Object?> get props => [role, content];
}
