import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../repositories/chatbot_repo.dart';

@injectable
class UpdateChatUseCase {
  final ChatbotRepo _repository;

  UpdateChatUseCase(this._repository);

  Future<Result<void>> call(
    String userId,
    String chatId,
    Map<String, dynamic> data,
  ) async {
    return await _repository.updateChat(userId, chatId, data);
  }
}
