import 'package:flutter/material.dart';

abstract class AppConstants {
  static const fontFamily = 'Baloo_Thambi_2';
  static const paddingHorizontal = 16.0;
  static const profileWebScreensBaseUrl =
      'https://elevate-flutter-team.github.io/fitness-app-webviews/';

  static const helpScreen = 'help.html';
  static const securityScreen = 'security.html';
  static const privacyPolicyScreen = 'privacy-policy.html';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static String getSocialPassword(String id) => 'Social@$id';
}
