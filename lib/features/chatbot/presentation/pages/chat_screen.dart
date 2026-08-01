import 'dart:ui';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_cubit.dart';
import 'package:fitness/features/chatbot/presentation/manager/chatbot_cubit/chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotCubit, ChatbotState>(
      builder: (context, state) {
        return CustomScaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 33),
                // Header (Frame 1261154535)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: AppColors.main,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 57),
                      // Title Text
                      const SizedBox(
                        width: 182,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Hi Ahmed ,\nI am your smart coach',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Baloo_Thambi_2',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 57),
                      // Menu Button
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(
                          child: Icon(
                            Icons.menu,
                            color: AppColors.main,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Frame 108
                Expanded(
                  child: Column(
                    children: [
                      // Robot Image
                      Expanded(
                        child: Image.asset(
                          AppAssets.botImage,
                          width: 343,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Bottom Card (Frame 15)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 17.3, sigmaY: 17.3),
                          child: Container(
                            width: double.infinity,
                            height: 194,
                            padding: const EdgeInsets.symmetric(
                              vertical: 40,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.darkCharcoal.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'How Can I Assist You Today ?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Baloo_Thambi_2',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Get Started Button (Frame 4)
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.chatWithBotRoute,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.main,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    minimumSize: const Size(74, 38),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Get Started',
                                    style: TextStyle(
                                      fontFamily: 'Baloo_Thambi_2',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
