import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_cubit.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_event.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatbotDrawer extends StatefulWidget {
  const ChatbotDrawer({super.key});

  @override
  State<ChatbotDrawer> createState() => _ChatbotDrawerState();
}

class _ChatbotDrawerState extends State<ChatbotDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<ChatbotCubit>().doEvents(GetChatsHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.pureBlack.withValues(alpha: 0.8),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Previous Conversations",
              style: AppTextStyles.bold20(
                context,
              ).copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: const Icon(Icons.add, color: AppColors.main),
                title: Text(
                  "New Chat",
                  style: AppTextStyles.bold16(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  context.read<ChatbotCubit>().doEvents(StartNewChatEvent());

                  final currentRoute = ModalRoute.of(context)?.settings.name;
                  if (currentRoute != Routes.chatScreen) {
                    Navigator.pushNamed(context, Routes.chatScreen);
                  }
                },
              ),
            ),
            const Divider(color: AppColors.gray3A, height: 1),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ChatbotCubit, ChatbotState>(
                builder: (context, state) {
                  if (state.historyState.isLoading) {
                    return const CustomLoadingIndicator();
                  } else if (state.historyState.errorMessage != null) {
                    return CustomErrorWidget(
                      errorMessage: state.historyState.errorMessage!,
                      onPressed: () => context.read<ChatbotCubit>().doEvents(
                        GetChatsHistoryEvent(),
                      ),
                    );
                  }

                  final chats = state.historyState.data ?? [];

                  if (chats.isEmpty) {
                    return Center(
                      child: Text(
                        "No previous chats",
                        style: AppTextStyles.medium16(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: chats.length,
                    separatorBuilder: (context, index) =>
                        const Divider(color: AppColors.gray3A, height: 1),
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      final isSelected = state.chatId == chat.id;
                      return ListTile(
                        leading: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.main,
                          size: 16,
                        ),
                        title: Text(
                          chat.title,
                          style: AppTextStyles.medium16(context).copyWith(
                            color: isSelected
                                ? AppColors.main
                                : AppColors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.pop(context); // Close drawer
                          context.read<ChatbotCubit>().doEvents(
                            LoadChatEvent(chat.id),
                          );

                          final currentRoute = ModalRoute.of(
                            context,
                          )?.settings.name;
                          if (currentRoute == Routes.chatScreen) {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.chatScreen,
                              arguments: chat.id,
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              Routes.chatScreen,
                              arguments: chat.id,
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
