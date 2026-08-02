import '../../../../config/error_handling/result.dart';
import '../entities/chat_entity.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chatbot_entity.dart';

abstract class ChatbotRepo {
  // Remote
  Future<Result<ChatbotEntity>> sendMessage(List<ChatMessageEntity> messages);

  Future<Result<String>> generateTitle(List<ChatMessageEntity> messages);

  Future<Result<String>> summarize(
    String? oldSummary,
    List<ChatMessageEntity> newMessages,
  );

  // Firestore
  Future<Result<List<ChatEntity>>> getChats(String userId);

  Future<Result<ChatEntity>> getChat(String userId, String chatId);

  Future<Result<void>> saveChat(String userId, ChatEntity chat);

  Future<Result<void>> updateChat(
    String userId,
    String chatId,
    Map<String, dynamic> data,
  );
}
