import 'dart:ui'; // Required for ImageFilter
import 'package:fitness/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final String backgroundImage;

  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.backgroundImage = AppAssets.authBackgroungImage,
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
        ),
      ),
    );
  }
}
