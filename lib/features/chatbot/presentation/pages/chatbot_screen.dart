import 'dart:ui';

import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/chatbot/presentation/widgets/chat_bubble.dart';
import 'package:fitness/features/chatbot/presentation/widgets/chatbot_drawer.dart';
import 'package:fitness/features/chatbot/presentation/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/values/chatbot_strings.dart';
import '../manager/chatbot_cubit/chatbot_cubit.dart';
import '../manager/chatbot_cubit/chatbot_event.dart';
import '../manager/chatbot_cubit/chatbot_state.dart';
import '../../../../core/shared_widgets/custom_scaffold.dart';

class ChatbotScreen extends StatefulWidget {
  final String? chatId;

  const ChatbotScreen({super.key, this.chatId});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  TextDirection _textDirection = TextDirection.ltr;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextDirection);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextDirection);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTextDirection() {
    if (_controller.text.isEmpty) {
      if (_textDirection != TextDirection.ltr) {
        setState(() => _textDirection = TextDirection.ltr);
      }
      return;
    }

    final firstChar = _controller.text.trim().characters.first;
    final isArabic = RegExp(r'^[\u0600-\u06FF]').hasMatch(firstChar);
    final newDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    if (newDirection != _textDirection) {
      setState(() => _textDirection = newDirection);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.user;

    return CustomScaffold(
      backgroundImage: AppAssets.chatbotBackground,
      endDrawer: const ChatbotDrawer(),
      appBar: AppBar(
        title: BlocBuilder<ChatbotCubit, ChatbotState>(
          builder: (context, state) => Text(state.title),
        ),
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: AppColors.main,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: AppColors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: AppColors.main),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocListener<ChatbotCubit, ChatbotState>(
        listenWhen: (previous, current) =>
            previous.messages.length != current.messages.length ||
            previous.chatState.isLoading != current.chatState.isLoading ||
            previous.chatState.errorMessage != current.chatState.errorMessage,
        listener: (context, state) {
          _scrollToBottom();
        },
        child: BlocBuilder<ChatbotCubit, ChatbotState>(
          builder: (context, state) {
            final messages = state.messages
                .where((m) => m.role != "system")
                .toList();

            return Column(
              children: [
                Expanded(
                  child: state.chatState.isLoading && messages.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount:
                              messages.length +
                              (state.chatState.isLoading ||
                                      state.chatState.errorMessage != null
                                  ? 1
                                  : 0),
                          itemBuilder: (context, index) {
                            if (index == messages.length) {
                              if (state.chatState.errorMessage != null) {
                                return ChatBubble(
                                  message: state.chatState.errorMessage!,
                                  isUser: false,
                                  isError: true,
                                  onRetry: () {
                                    context.read<ChatbotCubit>().doEvents(
                                      RetrySendMessageEvent(),
                                    );
                                  },
                                );
                              }
                              return const ChatBubble(
                                message: "",
                                isUser: false,
                                customContent: TypingIndicator(),
                              );
                            }
                            final msg = messages[index];
                            return ChatBubble(
                              message: msg.content,
                              isUser: msg.role == "user",
                              userImageUrl: user?.photo,
                            );
                          },
                        ),
                ),
                _buildInputArea(state.chatState.isLoading),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputArea(bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureBlack.withValues(alpha: 0.3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.darkCharcoal.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textDirection: _textDirection,
                    enabled: !isLoading,
                    style: AppTextStyles.regular16(
                      context,
                    ).copyWith(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: ChatbotStrings.askSmartCoach,
                      hintStyle: AppTextStyles.regular16(
                        context,
                      ).copyWith(color: AppColors.grayBD),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (value) {
                      if (!isLoading) _handleSend();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: isLoading ? null : _handleSend,
                  child: CircleAvatar(
                    backgroundColor: isLoading
                        ? AppColors.gray66
                        : AppColors.main,
                    radius: 22,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(
                            Icons.send_rounded,
                            color: AppColors.white,
                            size: 20,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty) {
      context.read<ChatbotCubit>().doEvents(
        SendMessageEvent(_controller.text.trim()),
      );
      _controller.clear();
    }
  }
}
