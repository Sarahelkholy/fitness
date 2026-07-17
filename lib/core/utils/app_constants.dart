import 'package:flutter/material.dart';

abstract class AppConstants {
  static const paddingHorizontal = 16.0;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static String getSocialPassword(String id) => 'Social@$id';
}
