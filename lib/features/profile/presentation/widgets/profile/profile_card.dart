import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleStyle,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.main, size: 22),
      title: Text(
        title,
        style: titleStyle ?? AppTextStyles.semiBold16(context),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.main,
        size: 16,
      ),
    );
  }
}
