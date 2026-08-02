import 'dart:ui';

import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/chatbot/presentation/widgets/chatbot_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/user/manager/user_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class WelcomeScreenChatbot extends StatelessWidget {
  const WelcomeScreenChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.user;
    return CustomScaffold(
      backgroundImage: AppAssets.chatbotBackground,
      endDrawer: const ChatbotDrawer(),
      appBar: AppBar(
        title: Text("Hi ${user!.firstName},\nI am your smart coach"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AppAssets.chatbotImage,
              width: double.infinity,
              height: 400,
            ),
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "How Can I Assist You\nToday ?",
                        style: AppTextStyles.extraBold24(context),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        title: "Get Started",
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.chatScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
