import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_cubit.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_event.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWithBotScreen extends StatefulWidget {
  const ChatWithBotScreen({super.key});

  @override
  State<ChatWithBotScreen> createState() => _ChatWithBotScreenState();
}

class _ChatWithBotScreenState extends State<ChatWithBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  late final List<Map<String, dynamic>> _messages;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
  }

  void _initializeMessages() {
    final state = context.read<ChatbotCubit>().state;
    if (state.messages.isNotEmpty) {
      _messages = state.messages
          .map((msg) => {
                'text': msg.content,
                'isBot': msg.role == 'model',
              })
          .toList();
    } else {
      _messages = [
        {
          'text':
              'Hello! I am your AI fitness coach. How can I help you today?',
          'isBot': true,
        },
      ];
    }
    _scrollToBottom();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
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

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isBot': false});
      _messageController.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    context.read<ChatbotCubit>().doEvents(SendMessageEvent(text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatbotCubit, ChatbotState>(
      listenWhen: (previous, current) => previous.messages != current.messages,
      listener: (context, state) {
        if (state.messages.isNotEmpty && state.messages.last.role == 'model') {
          setState(() {
            _isTyping = false;
            _messages.add({'text': state.messages.last.content, 'isBot': true});
          });
          _scrollToBottom();
        }
      },
      child: CustomScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Smart Coach',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Baloo_Thambi_2',
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return const Align(
                      alignment: Alignment.centerLeft,
                      child: TypingIndicator(),
                    );
                  }
                  final message = _messages[index];
                  final isBot = message['isBot'] as bool;

                  return Align(
                    alignment: isBot
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isBot ? AppColors.darkCharcoal : AppColors.main,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: Radius.circular(isBot ? 0 : 20),
                          bottomRight: Radius.circular(isBot ? 20 : 0),
                        ),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      child: Text(
                        message['text'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Baloo_Thambi_2',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkCharcoal.withOpacity(0.8),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white.withOpacity(0.1),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.main,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;
  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();
    _appearanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..forward();

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _appearanceController,
      builder: (context, child) {
        return Opacity(opacity: _appearanceController.value, child: child);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: AppColors.darkCharcoal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(0),
            const SizedBox(width: 4),
            _buildDot(1),
            const SizedBox(width: 4),
            _buildDot(2),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _repeatingController,
      builder: (context, child) {
        final double animValue = _repeatingController.value;
        final double dotValue = _dotIntervals[index].transform(animValue);
        final double opacity = Curves.easeInOut.transform(dotValue);

        return Opacity(
          opacity: opacity,
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
