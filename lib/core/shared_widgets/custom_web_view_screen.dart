import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
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
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = true;
              hasError = false;
            });
          },
          onPageFinished: (_) {
            if (!hasError) {
              setState(() => isLoading = false);
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (error.isForMainFrame ?? true) {
              setState(() {
                isLoading = false;
                hasError = true;
              });
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          "${AppConstants.profileWebScreensBaseUrl}/${widget.fileName}",
        ),
      );
  }

  void _reloadPage() {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.darkCharcoal,
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          if (!hasError) WebViewWidget(controller: controller),
          if (hasError)
            Center(
              child: CustomErrorWidget(
                errorMessage: localizations.unexpectedErrorMessage,
                haveTryAgain: true,
                onPressed: _reloadPage,
              ),
            ),
          if (isLoading && !hasError)
            Container(
              color: AppColors.darkCharcoal,
              child: const CustomLoadingIndicator(),
            ),
        ],
      ),
    );
  }
}

