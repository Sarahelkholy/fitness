import '../../../../../config/error_handling/result.dart';
import '../../models/responses/chat_model.dart';

abstract class ChatbotFirestoreDataSource {
  Future<Result<List<ChatModel>>> getChats(String userId);

  Future<Result<ChatModel?>> getChat(String userId, String chatId);

  Future<Result<void>> saveChat(String userId, ChatModel chat);

  Future<Result<void>> updateChat(
    String userId,
    String chatId,
    Map<String, dynamic> data,
  );
}
