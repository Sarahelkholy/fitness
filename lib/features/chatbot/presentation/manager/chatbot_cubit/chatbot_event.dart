sealed class ChatbotEvents {}

class SendMessageEvent extends ChatbotEvents {
  final String message;

  SendMessageEvent(this.message);
}

class StartNewChatEvent extends ChatbotEvents {}

class LoadChatEvent extends ChatbotEvents {
  final String chatId;

  LoadChatEvent(this.chatId);
}

class GetChatsHistoryEvent extends ChatbotEvents {}

class RetrySendMessageEvent extends ChatbotEvents {}
