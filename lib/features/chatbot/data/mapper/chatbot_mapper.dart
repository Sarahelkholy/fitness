import '../../domain/entities/chatbot_entity.dart';
import '../models/requests/chatbot_request.dart';
import '../models/responses/chatbot_response.dart';

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

extension ChatMessageMapper on ChatMessageModel {
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(role: role, content: content);
  }
}

extension ChatMessageEntityMapper on ChatMessageEntity {
  ChatMessageModel toModel() {
    return ChatMessageModel(role: role, content: content);
  }
}
