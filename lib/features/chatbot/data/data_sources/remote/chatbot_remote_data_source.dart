import '../../../../../config/error_handling/result.dart';
import '../../models/requests/chatbot_request.dart';
import '../../models/responses/chatbot_response.dart';

abstract class ChatbotRemoteDataSource {
  Future<Result<ChatbotResponse>> chat(ChatbotRequest request);
}
