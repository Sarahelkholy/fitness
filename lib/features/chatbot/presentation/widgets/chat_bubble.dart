import 'package:fitness/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String? userImageUrl;
  final Widget? customContent;
  final VoidCallback? onRetry;
  final bool isError;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    this.userImageUrl,
    this.customContent,
    this.onRetry,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(message);
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(false),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: isError
                        ? AppColors.error
                        : (isUser ? AppColors.main : AppColors.gray3A),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20),
                      topRight: isUser
                          ? Radius.zero
                          : const Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pureBlack.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                      if (isError)
                        BoxShadow(
                          color: AppColors.error.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child:
                      customContent ??
                      Text(
                        message,
                        textDirection: textDirection,
                        style: AppTextStyles.regular16(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                ),
                if (isError && onRetry != null) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: onRetry,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.pureBlack.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.refresh_rounded,
                            size: 20,
                            color: AppColors.error,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Try Again",
                            style: AppTextStyles.bold14(
                              context,
                            ).copyWith(color: AppColors.error),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool user) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.main, width: 1),
      ),
      child: ClipOval(
        child: user
            ? (userImageUrl != null && userImageUrl!.isNotEmpty
                  ? CachedNetworkImageWrapper(imagePath: userImageUrl!)
                  : Image.asset(AppAssets.userTestImage, fit: BoxFit.cover))
            : Image.asset(AppAssets.chatbotImage, fit: BoxFit.cover),
      ),
    );
  }
}
