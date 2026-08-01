import '../../../../config/error_handling/result.dart';
import '../entities/chatbot_entity.dart';

abstract class ChatbotRepo {
  Future<Result<ChatbotEntity>> sendMessage(List<ChatMessageEntity> messages);
}
