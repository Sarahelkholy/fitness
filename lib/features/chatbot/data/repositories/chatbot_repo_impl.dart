import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../core/values/chatbot_strings.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chatbot_entity.dart';
import '../../domain/repositories/chatbot_repo.dart';
import '../data_sources/remote/chatbot_firestore_data_source.dart';
import '../data_sources/remote/chatbot_remote_data_source.dart';
import '../mapper/chat_mapper.dart';
import '../mapper/chat_message_mapper.dart';
import '../mapper/chatbot_response_mapper.dart';
import '../models/requests/chat_message_model.dart';
import '../models/requests/chatbot_request.dart';

@Injectable(as: ChatbotRepo)
class ChatbotRepoImpl implements ChatbotRepo {
  final ChatbotRemoteDataSource _remoteDataSource;
  final ChatbotFirestoreDataSource _firestoreDataSource;

  ChatbotRepoImpl(this._remoteDataSource, this._firestoreDataSource);

  @override
  Future<Result<ChatbotEntity>> sendMessage(
    List<ChatMessageEntity> messages,
  ) async {
    final request = ChatbotRequest(
      model: ChatbotStrings.chatbotModel,
      messages: messages.map((e) => e.toModel()).toList(),
    );

    final result = await _remoteDataSource.chat(request);

    return switch (result) {
      Success(data: final response) => Success(data: response.toEntity()),
      Failure(errorMessage: final message) => Failure(errorMessage: message),
    };
  }

  @override
  Future<Result<String>> generateTitle(List<ChatMessageEntity> messages) async {
    final apiMessages = [
      ...messages.map((e) => e.toModel()),
      ChatMessageModel(role: "user", content: ChatbotStrings.titlePrompt),
    ];

    final request = ChatbotRequest(
      model: ChatbotStrings.chatbotModel,
      messages: apiMessages,
    );

    final result = await _remoteDataSource.chat(request);

    return switch (result) {
      Success(data: final response) => Success(
        data: response.message?.content ?? ChatbotStrings.newChat,
      ),
      Failure(errorMessage: final message) => Failure(errorMessage: message),
    };
  }

  @override
  Future<Result<String>> summarize(
    String? oldSummary,
    List<ChatMessageEntity> newMessages,
  ) async {
    String prompt = ChatbotStrings.summaryPrompt;

    if (oldSummary != null && oldSummary.isNotEmpty) {
      prompt =
          "Old Summary: $oldSummary\n\nNew Messages to add to summary:\n"
          "$prompt";
    }

    final apiMessages = [
      ...newMessages.map((e) => e.toModel()),
      ChatMessageModel(role: "user", content: prompt),
    ];

    final request = ChatbotRequest(
      model: ChatbotStrings.chatbotModel,
      messages: apiMessages,
    );

    final result = await _remoteDataSource.chat(request);

    return switch (result) {
      Success(data: final response) => Success(
        data: response.message?.content ?? "",
      ),
      Failure(errorMessage: final message) => Failure(errorMessage: message),
    };
  }

  @override
  Future<Result<List<ChatEntity>>> getChats(String userId) async {
    final result = await _firestoreDataSource.getChats(userId);
    return switch (result) {
      Success(data: final models) => Success(
        data: models.map((e) => e.toEntity()).toList(),
      ),
      Failure(errorMessage: final message) => Failure(errorMessage: message),
    };
  }

  @override
  Future<Result<ChatEntity>> getChat(String userId, String chatId) async {
    final result = await _firestoreDataSource.getChat(userId, chatId);
    return switch (result) {
      Success(data: final model) =>
        model != null
            ? Success(data: model.toEntity())
            : Failure(errorMessage: "Chat not found"),
      Failure(errorMessage: final message) => Failure(errorMessage: message),
    };
  }

  @override
  Future<Result<void>> saveChat(String userId, ChatEntity chat) async {
    return await _firestoreDataSource.saveChat(userId, chat.toModel());
  }

  @override
  Future<Result<void>> updateChat(
    String userId,
    String chatId,
    Map<String, dynamic> data,
  ) async {
    return await _firestoreDataSource.updateChat(userId, chatId, data);
  }
}
