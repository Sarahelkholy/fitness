import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/chatbot_repo.dart';

@injectable
class SummarizeUseCase {
  final ChatbotRepo _repository;

  SummarizeUseCase(this._repository);

  Future<Result<String>> call(
    String? oldSummary,
    List<ChatMessageEntity> newMessages,
  ) async {
    return await _repository.summarize(oldSummary, newMessages);
  }
}
