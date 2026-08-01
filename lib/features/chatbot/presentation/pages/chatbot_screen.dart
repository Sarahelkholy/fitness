import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/chatbot_cubit/chatbot_cubit.dart';
import '../manager/chatbot_cubit/chatbot_state.dart';
import '../../../../core/shared_widgets/custom_scaffold.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(title: const Text('Chatbot')),
      body: BlocBuilder<ChatbotCubit, ChatbotState>(
        builder: (context, state) {
          return const Center(child: Text('Chatbot Screen'));
        },
      ),
    );
  }
}
