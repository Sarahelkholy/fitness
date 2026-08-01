import '../../../../config/error_handling/result.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chatbot_entity.dart';

abstract class ChatbotRepo {
  Future<Result<ChatbotEntity>> sendMessage(List<ChatMessageEntity> messages);
}
