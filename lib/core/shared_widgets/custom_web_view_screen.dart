// lib/core/shared_widgets/custom_web_view_screen.dart

import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewScreen extends StatefulWidget {
  final String title;
  final String fileName;

  const CustomWebViewScreen({
    super.key,
    required this.title,
    required this.fileName,
  });

  @override
  State<CustomWebViewScreen> createState() => _CustomWebViewScreenState();
}

class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => isLoading = true);
          },
          onPageFinished: (_) {
            setState(() => isLoading = false);
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          "${AppConstants.profileWebScreensBaseUrl}/${widget.fileName}",
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkCharcoal,
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Container(
              color: AppColors.darkCharcoal,
              child: const CustomLoadingIndicator(),
            ),
        ],
      ),
    );
  }
}
