sealed class ChatbotEvents {}

class SendMessageEvent extends ChatbotEvents {
  final String message;

  SendMessageEvent(this.message);
}
