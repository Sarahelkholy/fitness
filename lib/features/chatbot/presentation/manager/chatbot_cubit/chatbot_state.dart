import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/chat_entity.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/entities/chatbot_entity.dart';

class ChatbotState extends Equatable {
  final BaseState<ChatbotEntity> chatState;
  final BaseState<List<ChatEntity>> historyState;
  final List<ChatMessageEntity> messages;
  final String? chatId;
  final String title;
  final String summary;

  const ChatbotState({
    this.chatState = const BaseState(),
    this.historyState = const BaseState(),
    this.messages = const [],
    this.chatId,
    this.title = "New Chat",
    this.summary = "",
  });

  ChatbotState copyWith({
    BaseState<ChatbotEntity>? chatStateParam,
    BaseState<List<ChatEntity>>? historyStateParam,
    List<ChatMessageEntity>? messagesParam,
    String? chatIdParam,
    String? titleParam,
    String? summaryParam,
  }) {
    return ChatbotState(
      chatState: chatStateParam ?? chatState,
      historyState: historyStateParam ?? historyState,
      messages: messagesParam ?? messages,
      chatId: chatIdParam ?? chatId,
      title: titleParam ?? title,
      summary: summaryParam ?? summary,
    );
  }

  @override
  List<Object?> get props => [
    chatState,
    historyState,
    messages,
    chatId,
    title,
    summary,
  ];
}
