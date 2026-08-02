import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? drawer;
  final Widget? endDrawer;
  final PreferredSizeWidget? appBar;
  final String backgroundImage;

  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.backgroundImage = AppAssets.authBackgroundImage,
    this.drawer,
    this.endDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        drawer: drawer,
        endDrawer: endDrawer,
        backgroundColor: AppColors.pureBlack.withValues(alpha: .5),
        appBar: appBar,
        body: body,
      ),
    );
  }
}
