import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text('chat', style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
