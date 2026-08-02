import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/chat_entity.dart';
import '../repositories/chatbot_repo.dart';

@injectable
class GetChatsUseCase {
  final ChatbotRepo _repository;

  GetChatsUseCase(this._repository);

  Future<Result<List<ChatEntity>>> call(String userId) async {
    return await _repository.getChats(userId);
  }
}
