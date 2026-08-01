import '../../domain/entities/chat_message_entity.dart';
import '../models/requests/chat_message_model.dart';

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
