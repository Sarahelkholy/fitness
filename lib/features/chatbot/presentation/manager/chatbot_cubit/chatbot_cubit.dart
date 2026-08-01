import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/features/chatbot/domain/entities/chat_message_entity.dart';
import 'package:injectable/injectable.dart';

import 'chatbot_event.dart';
import 'chatbot_state.dart';

@injectable
class ChatbotCubit extends BaseCubit<ChatbotState, BaseEvent> {
  ChatbotCubit() : super(const ChatbotState());

  void doEvents(ChatbotEvents event) {
    switch (event) {
      case SendMessageEvent():
        _sendMessage(event.message);
    }
  }

  Future<void> _sendMessage(String userMessage) async {
    // 1. Add user message to state
    final updatedMessages = List<ChatMessageEntity>.from(state.messages);
    updatedMessages.add(ChatMessageEntity(role: 'user', content: userMessage));

    emit(state.copyWith(messagesParam: updatedMessages));

    // 2. Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // 3. Add bot response to state
    final messagesWithResponse =
        List<ChatMessageEntity>.from(state.messages);
    messagesWithResponse.add(ChatMessageEntity(
      role: 'model',
      content:
          'I received your message: "$userMessage". How can I help you further with your fitness goals?',
    ));

    emit(state.copyWith(messagesParam: messagesWithResponse));
  }
}
