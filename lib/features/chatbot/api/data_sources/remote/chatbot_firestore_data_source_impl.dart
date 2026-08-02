import 'package:injectable/injectable.dart';

import '../../../../../config/data_base/data_base_service.dart';
import '../../../../../config/error_handling/execute_api.dart';
import '../../../../../config/error_handling/result.dart';
import '../../../../../config/firebase/firestore_collection.dart';
import '../../../data/data_sources/remote/chatbot_firestore_data_source.dart';
import '../../../data/models/responses/chat_model.dart';

@Injectable(as: ChatbotFirestoreDataSource)
class ChatbotFirestoreDataSourceImpl implements ChatbotFirestoreDataSource {
  final DatabaseService _databaseService;

  ChatbotFirestoreDataSourceImpl(this._databaseService);

  String _getUserChatsPath(String userId) =>
      "${FireStoreCollection.usersCollectionPath}/$userId/${FireStoreCollection.chatsCollectionPath}";

  String _getChatPath(String userId, String chatId) =>
      "${_getUserChatsPath(userId)}/$chatId";

  @override
  Future<Result<List<ChatModel>>> getChats(String userId) async {
    return await executeApi(() async {
      return await _databaseService.getCollection<ChatModel>(
        path: _getUserChatsPath(userId),
        fromFirestore: (json, id) => ChatModel.fromFirestore(json, id),
      );
    });
  }

  @override
  Future<Result<ChatModel?>> getChat(String userId, String chatId) async {
    return await executeApi(() async {
      return await _databaseService.getDocument<ChatModel>(
        path: _getChatPath(userId, chatId),
        fromFirestore: (json, id) => ChatModel.fromFirestore(json, id),
      );
    });
  }

  @override
  Future<Result<void>> saveChat(String userId, ChatModel chat) async {
    return await executeApi(() async {
      return await _databaseService.setData<ChatModel>(
        path: _getChatPath(userId, chat.id),
        data: chat,
        toFirestore: (value) => value.toFirestore(),
      );
    });
  }

  @override
  Future<Result<void>> updateChat(
    String userId,
    String chatId,
    Map<String, dynamic> data,
  ) async {
    return await executeApi(() async {
      return await _databaseService.updateData(
        path: _getChatPath(userId, chatId),
        data: data,
      );
    });
  }
}
