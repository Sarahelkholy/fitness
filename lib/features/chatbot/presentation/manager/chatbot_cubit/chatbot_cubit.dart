import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:injectable/injectable.dart';

import 'chatbot_event.dart';
import 'chatbot_state.dart';

@injectable
class ChatbotCubit extends BaseCubit<ChatbotState, BaseEvent> {
  ChatbotCubit() : super(const ChatbotState());

  void doEvents(ChatbotEvents event) {
    switch (event) {
      case SendMessageEvent():
        _sendMessage(event.message);
    }
  }

  Future<void> _sendMessage(String userMessage) async {}
}
