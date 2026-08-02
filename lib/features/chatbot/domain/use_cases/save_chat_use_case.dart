import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/chat_entity.dart';
import '../repositories/chatbot_repo.dart';

@injectable
class SaveChatUseCase {
  final ChatbotRepo _repository;

  SaveChatUseCase(this._repository);

  Future<Result<void>> call(String userId, ChatEntity chat) async {
    return await _repository.saveChat(userId, chat);
  }
}
