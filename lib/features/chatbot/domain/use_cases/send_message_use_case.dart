import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chatbot_entity.dart';
import '../repositories/chatbot_repo.dart';

@injectable
class SendMessageUseCase {
  final ChatbotRepo _repository;

  SendMessageUseCase(this._repository);

  Future<Result<ChatbotEntity>> call(List<ChatMessageEntity> messages) async {
    return await _repository.sendMessage(messages);
  }
}
