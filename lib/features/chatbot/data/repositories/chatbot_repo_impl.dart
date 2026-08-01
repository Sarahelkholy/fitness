import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../domain/entities/chatbot_entity.dart';
import '../../domain/repositories/chatbot_repo.dart';
import '../data_sources/remote/chatbot_remote_data_source.dart';
import '../mapper/chatbot_mapper.dart';
import '../models/requests/chatbot_request.dart';
import '../models/responses/chatbot_response.dart';

@Injectable(as: ChatbotRepo)
class ChatbotRepoImpl implements ChatbotRepo {
  final ChatbotRemoteDataSource _remoteDataSource;

  ChatbotRepoImpl(this._remoteDataSource);

  @override
  Future<Result<ChatbotEntity>> sendMessage(
    List<ChatMessageEntity> messages,
  ) async {
    final request = ChatbotRequest(
      model: "qwen2.5:7b",
      messages: messages.map((e) => e.toModel()).toList(),
    );

    final result = await _remoteDataSource.chat(request);

    switch (result) {
      case Success<ChatbotResponse>():
        return Success(data: result.data.toEntity());
      case Failure<ChatbotResponse>():
        return Failure(errorMessage: result.errorMessage);
    }
  }
}
