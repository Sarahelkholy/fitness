import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/chatbot_entity.dart';

class ChatbotState extends Equatable {
  final BaseState<ChatbotEntity> chatState;
  final List<ChatMessageEntity> messages;

  const ChatbotState({
    this.chatState = const BaseState(),
    this.messages = const [],
  });

  ChatbotState copyWith({
    BaseState<ChatbotEntity>? chatStateParam,
    List<ChatMessageEntity>? messagesParam,
  }) {
    return ChatbotState(
      chatState: chatStateParam ?? chatState,
      messages: messagesParam ?? messages,
    );
  }

  @override
  List<Object?> get props => [chatState, messages];
}
