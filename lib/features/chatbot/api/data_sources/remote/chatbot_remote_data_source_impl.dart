import 'package:injectable/injectable.dart';
import '../../../../../config/error_handling/execute_api.dart';
import '../../../../../config/error_handling/result.dart';
import '../../../data/data_sources/remote/chatbot_remote_data_source.dart';
import '../../../data/models/requests/chatbot_request.dart';
import '../../../data/models/responses/chatbot_response.dart';
import '../../chatbot_api_client/chatbot_api_client.dart';

@Injectable(as: ChatbotRemoteDataSource)
class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
  final ChatbotApiClient _apiClient;

  ChatbotRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ChatbotResponse>> chat(ChatbotRequest request) {
    return executeApi(() async {
      return await _apiClient.chat(request);
    });
  }
}
