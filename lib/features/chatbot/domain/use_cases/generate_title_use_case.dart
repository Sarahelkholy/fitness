import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/chatbot_repo.dart';

@injectable
class GenerateTitleUseCase {
  final ChatbotRepo _repository;

  GenerateTitleUseCase(this._repository);

  Future<Result<String>> call(List<ChatMessageEntity> messages) async {
    return await _repository.generateTitle(messages);
  }
}
