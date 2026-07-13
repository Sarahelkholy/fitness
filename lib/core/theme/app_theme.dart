import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) {
    return ThemeData(
      textTheme: GoogleFonts.interTextTheme(),
      useMaterial3: true,
      brightness: Brightness.dark,

      ///? Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorMaxLines: 2,
        labelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTextStyles.regular12(
              context,
            ).copyWith(color: AppColors.error);
          }
          return AppTextStyles.regular12(
            context,
          ).copyWith(color: AppColors.grayD3);
        }),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTextStyles.regular12(
              context,
            ).copyWith(color: AppColors.error);
          }
          return AppTextStyles.regular12(
            context,
          ).copyWith(color: AppColors.grayD3);
        }),

        errorStyle: AppTextStyles.regular12(
          context,
        ).copyWith(color: AppColors.error),
        hintStyle: AppTextStyles.regular12(
          context,
        ).copyWith(color: AppColors.grayD3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.grayD3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.grayD3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.grayD3),
        ),
      ),

      ///?  Search Bar
      // searchBarTheme: SearchBarThemeData(
      //   hintStyle: WidgetStatePropertyAll(
      //     AppTextStyles.medium14(
      //       context,
      //     ).copyWith(color: AppColors.textHint, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: WidgetStateProperty.all(AppColors.background),
      //   elevation: WidgetStateProperty.all(0),
      //   padding: WidgetStateProperty.all(
      //     const EdgeInsets.symmetric(horizontal: 16),
      //   ),
      //   shape: WidgetStateProperty.all(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //       side: const BorderSide(color: AppColors.textHint, width: 1.5),
      //     ),
      //   ),
      // ),

      ///?  Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledForegroundColor: AppColors.grayD3,
          minimumSize: const Size(double.infinity, 38),
          textStyle: AppTextStyles.medium16(context),
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.main,
          disabledBackgroundColor: AppColors.grayD3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),

      ///?  AppBar
      appBarTheme: AppBarTheme(
        titleSpacing: 0,

        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.semiBold24(context),
        iconTheme: const IconThemeData(color: AppColors.main),
      ),

      ///?  Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.main,
      ),

      ///?  Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,

        elevation: 1,

        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

        indicatorColor: Colors.transparent,

        overlayColor: WidgetStateProperty.all(
          AppColors.main.withValues(alpha: 0.2),
        ),

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return AppTextStyles.regular12(
            context,
          ).copyWith(color: AppColors.main);
        }),
      ),
    );
  }
}
