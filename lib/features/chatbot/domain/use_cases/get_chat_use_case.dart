import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/chat_entity.dart';
import '../repositories/chatbot_repo.dart';

@injectable
class GetChatUseCase {
  final ChatbotRepo _repository;

  GetChatUseCase(this._repository);

  Future<Result<ChatEntity>> call(String userId, String chatId) async {
    return await _repository.getChat(userId, chatId);
  }
}
