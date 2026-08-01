import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/values/api_end_points.dart';
import '../../../../core/values/api_strings.dart';
import '../../data/models/requests/chatbot_request.dart';
import '../../data/models/responses/chatbot_response.dart';

part 'chatbot_api_client.g.dart';

@injectable
@RestApi()
abstract class ChatbotApiClient {
  @factoryMethod
  factory ChatbotApiClient(@Named(ApiStrings.chatBotDio) Dio dio) =
      _ChatbotApiClient;

  @POST(ApiEndPoints.chatPath)
  Future<ChatbotResponse> chat(@Body() ChatbotRequest request);
}
