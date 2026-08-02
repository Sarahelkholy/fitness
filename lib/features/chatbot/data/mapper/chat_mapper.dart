import '../../domain/entities/chat_entity.dart';
import '../models/responses/chat_model.dart';
import 'chat_message_mapper.dart';

extension ChatMapper on ChatModel {
  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      title: title,
      summary: summary,
      messages: messages.map((e) => e.toEntity()).toList(),
      lastUpdated: lastUpdated,
    );
  }
}

extension ChatEntityMapper on ChatEntity {
  ChatModel toModel() {
    return ChatModel(
      id: id,
      title: title,
      summary: summary,
      messages: messages.map((e) => e.toModel()).toList(),
      lastUpdated: lastUpdated,
    );
  }
}
