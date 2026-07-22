import 'package:fitness/core/shared_widgets/svg_wrapper.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:flutter/material.dart';

class SocialRowWidget extends StatelessWidget {
  const SocialRowWidget({
    super.key,
    required this.facebookOnTap,
    required this.googleOnTap,
    required this.appleOnTap,
    required this.isLoading,
  });

  final VoidCallback facebookOnTap;
  final VoidCallback googleOnTap;
  final VoidCallback appleOnTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIconButtonWidget(
          key: const Key(KeysStrings.registerFacebookButton),
          imagePath: AppAssets.facebookIcon,
          onTap: isLoading ? null : facebookOnTap,
        ),
        const SizedBox(width: 16),
        SocialIconButtonWidget(
          key: const Key(KeysStrings.registerGoogleButton),
          imagePath: AppAssets.googleIcon,
          onTap: isLoading ? null : googleOnTap,
        ),
        const SizedBox(width: 16),
        SocialIconButtonWidget(
          imagePath: AppAssets.appleIcon,
          onTap: isLoading ? null : appleOnTap,
        ),
      ],
    );
  }
}

class SocialIconButtonWidget extends StatelessWidget {
  const SocialIconButtonWidget({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  final String imagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.darkCharcoal),
      ),
      onPressed: onTap,
      icon: SvgWrapper(
        path: imagePath,
        width: 16,
        height: 16,
        color: AppColors.white,
      ),
    );
  }
}
