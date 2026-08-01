import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chatbot_entity.dart';
import '../models/responses/chatbot_response.dart';
import 'chat_message_mapper.dart';

extension ChatbotResponseMapper on ChatbotResponse {
  ChatbotEntity toEntity() {
    return ChatbotEntity(
      model: model ?? "",
      message:
          message?.toEntity() ?? const ChatMessageEntity(role: "", content: ""),
      done: done ?? false,
    );
  }
}
