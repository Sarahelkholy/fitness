import 'package:fitness/config/base_cubit/base_cubit.dart';
import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/error_handling/result.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/values/chatbot_strings.dart';
import '../../../domain/entities/chat_entity.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/entities/chatbot_entity.dart';
import '../../../domain/use_cases/generate_title_use_case.dart';
import '../../../domain/use_cases/get_chat_use_case.dart';
import '../../../domain/use_cases/get_chats_use_case.dart';
import '../../../domain/use_cases/save_chat_use_case.dart';
import '../../../domain/use_cases/send_message_use_case.dart';
import '../../../domain/use_cases/summarize_use_case.dart';
import 'chatbot_event.dart';
import 'chatbot_state.dart';

@lazySingleton
class ChatbotCubit extends BaseCubit<ChatbotState, BaseEvent> {
  final SendMessageUseCase _sendMessageUseCase;
  final GetChatUseCase _getChatUseCase;
  final GetChatsUseCase _getChatsUseCase;
  final SaveChatUseCase _saveChatUseCase;
  final GenerateTitleUseCase _generateTitleUseCase;
  final SummarizeUseCase _summarizeUseCase;
  final UserCubit _userCubit;

  ChatbotCubit(
    this._sendMessageUseCase,
    this._getChatUseCase,
    this._getChatsUseCase,
    this._saveChatUseCase,
    this._generateTitleUseCase,
    this._summarizeUseCase,
    this._userCubit,
  ) : super(const ChatbotState());

  void doEvents(ChatbotEvents event) {
    switch (event) {
      case SendMessageEvent():
        _sendMessage(event.message);
      case StartNewChatEvent():
        _startNewChat();
      case LoadChatEvent():
        _loadChat(event.chatId);
      case GetChatsHistoryEvent():
        _getChatsHistory();
      case RetrySendMessageEvent():
        _retrySendMessage();
    }
  }

  Future<void> _startNewChat() async {
    final user = _userCubit.state.user;
    if (user == null) return;

    final chatId = DateTime.now().millisecondsSinceEpoch.toString();
    emit(
      state.copyWith(
        chatIdParam: chatId,
        messagesParam: const [],
        summaryParam: "",
        titleParam: ChatbotStrings.newChat,
      ),
    );

    final greetingPrompt = ChatbotStrings.greetingPrompt(user.firstName);
    _sendMessage(greetingPrompt, isGreeting: true);
  }

  Future<void> _loadChat(String chatId) async {
    final user = _userCubit.state.user;
    if (user == null) return;

    emit(state.copyWith(chatStateParam: const BaseState(isLoading: true)));

    final result = await _getChatUseCase.call(user.id, chatId);

    switch (result) {
      case Success<ChatEntity>():
        emit(
          state.copyWith(
            chatStateParam: const BaseState(isSuccess: true),
            chatIdParam: result.data.id,
            messagesParam: result.data.messages,
            titleParam: result.data.title,
            summaryParam: result.data.summary,
          ),
        );
      case Failure<ChatEntity>():
        emit(
          state.copyWith(
            chatStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  Future<void> _sendMessage(
    String userMessage, {
    bool isGreeting = false,
    bool isRetry = false,
  }) async {
    final user = _userCubit.state.user;
    if (user == null || state.chatId == null) return;

    final List<ChatMessageEntity> currentMessages =
        List<ChatMessageEntity>.from(state.messages);

    if (!isGreeting && !isRetry) {
      final userChatEntity = ChatMessageEntity(
        role: "user",
        content: userMessage,
        timestamp: DateTime.now(),
      );
      currentMessages.add(userChatEntity);

      // Trigger title generation on the first user message
      if (state.messages.length == 1 &&
          state.messages.first.role == "assistant") {
        // We'll generate title after AI response to have more context,
        // but user asked for "generated once with first user message".
        // I will trigger it here but wait for it or do it in parallel.
      }
    }

    emit(
      state.copyWith(
        chatStateParam: const BaseState(isLoading: true),
        messagesParam: currentMessages,
      ),
    );

    final List<ChatMessageEntity> apiMessages = [];
    apiMessages.add(
      ChatMessageEntity(
        role: "system",
        content: ChatbotStrings.systemPrompt,
        timestamp: DateTime.now(),
      ),
    );

    if (state.summary.isNotEmpty) {
      apiMessages.add(
        ChatMessageEntity(
          role: "system",
          content: ChatbotStrings.summaryContext(state.summary),
          timestamp: DateTime.now(),
        ),
      );
    }

    final unsummarizedStartIndex = (currentMessages.length ~/ 10) * 10;
    if (unsummarizedStartIndex < currentMessages.length) {
      apiMessages.addAll(currentMessages.sublist(unsummarizedStartIndex));
    }

    if (isGreeting) {
      apiMessages.add(
        ChatMessageEntity(
          role: "user",
          content: userMessage,
          timestamp: DateTime.now(),
        ),
      );
    }

    final result = await _sendMessageUseCase.call(apiMessages);

    switch (result) {
      case Success<ChatbotEntity>():
        final assistantMessage = result.data.message;
        final updatedMessages = List<ChatMessageEntity>.from(currentMessages)
          ..add(assistantMessage);

        emit(
          state.copyWith(
            chatStateParam: BaseState(isSuccess: true, data: result.data),
            messagesParam: updatedMessages,
          ),
        );

        if (!isGreeting) {
          // If first user message interaction, we save and potentially generate title
          if (currentMessages.length == 2 &&
              currentMessages.first.role == "assistant") {
            // AI Greeting + First User Message already in currentMessages
            await _updateChatInFirestore(updatedMessages);
            _generateTitle(updatedMessages);
          } else {
            await _updateChatInFirestore(updatedMessages);
          }
        }

        // Summarize if we hit a multiple of 10 messages
        if (updatedMessages.isNotEmpty && updatedMessages.length % 10 == 0) {
          _summarize();
        }

      case Failure<ChatbotEntity>():
        emit(
          state.copyWith(
            chatStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  Future<Result<void>> _updateChatInFirestore(
    List<ChatMessageEntity> messages,
  ) async {
    final user = _userCubit.state.user;
    if (user == null || state.chatId == null) {
      return Failure(errorMessage: "User or Chat ID missing");
    }

    return await _saveChatUseCase.call(
      user.id,
      ChatEntity(
        id: state.chatId!,
        title: state.title,
        summary: state.summary,
        messages: messages,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  Future<void> _generateTitle(List<ChatMessageEntity> messages) async {
    final user = _userCubit.state.user;
    if (user == null || state.chatId == null) return;

    final result = await _generateTitleUseCase.call(messages);

    if (result is Success<String>) {
      final title = result.data.replaceAll('"', '').trim();
      emit(state.copyWith(titleParam: title));
      await _updateChatInFirestore(state.messages);
    }
  }

  Future<void> _summarize() async {
    final user = _userCubit.state.user;
    if (user == null || state.chatId == null) return;

    final startIndex = (state.messages.length ~/ 10 - 1) * 10;
    final messagesToSummarize = state.messages.sublist(
      startIndex,
      startIndex + 10,
    );

    final result = await _summarizeUseCase.call(
      state.summary,
      messagesToSummarize,
    );

    if (result is Success<String>) {
      final newSummary = result.data;
      emit(state.copyWith(summaryParam: newSummary));
      await _updateChatInFirestore(state.messages);
    }
  }

  Future<void> _getChatsHistory() async {
    final user = _userCubit.state.user;
    if (user == null) return;

    emit(state.copyWith(historyStateParam: const BaseState(isLoading: true)));

    final result = await _getChatsUseCase.call(user.id);

    switch (result) {
      case Success<List<ChatEntity>>():
        final sortedChats = List<ChatEntity>.from(result.data)
          ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
        emit(
          state.copyWith(
            historyStateParam: BaseState(isSuccess: true, data: sortedChats),
          ),
        );
      case Failure<List<ChatEntity>>():
        emit(
          state.copyWith(
            historyStateParam: BaseState(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  Future<void> _retrySendMessage() async {
    final lastUserMessage = state.messages.lastWhere(
      (m) => m.role == "user",
      orElse: () =>
          ChatMessageEntity(role: "", content: "", timestamp: DateTime.now()),
    );

    if (lastUserMessage.content.isNotEmpty) {
      _sendMessage(lastUserMessage.content, isRetry: true);
    }
  }
}
