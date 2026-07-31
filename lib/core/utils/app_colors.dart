import 'package:flutter/material.dart';

abstract class AppColors {
  // --- Monochromatic / Grayscale (White to Black) ---
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkCharcoal = Color(0xFF242424);
  static const Color jetBlack = Color(0xFF0B0B0B);
  static const Color pureBlack = Color(0xFF000000);

  // --- Real Grays (Light to Dark) ---
  static const Color gray3A = Color(0xFF3A3A3A);
  static const Color gray50 = Color(0xFF505050);
  static const Color gray66 = Color(0xFF666666);
  static const Color gray7C = Color(0xFF7C7C7C);
  static const Color gray91 = Color(0xFF919191);
  static const Color grayA7 = Color(0xFFA7A7A7);
  static const Color grayBD = Color(0xFFBDBDBD);
  static const Color grayD3 = Color(0xFFD3D3D3);
  static const Color grayE9 = Color(0xFFE9E9E9);

  // --- Brand / Main Colors (Oranges) ---
  static const Color main = Color(0xFFFF4100); // تم تركها كما هي
  static const Color orangeShade7 = Color(0xFFFF541A);
  static const Color orangeHint = Color(0xFFFF6733);
  static const Color orangeMuted = Color(0xFFFF7A4D);
  static const Color orangeCheckbox = Color(0xFFFF8D66);
  static const Color orangeButtonText = Color(0xFFFF0A80);
  static const Color orangeLight10 = Color(0xffFFB399);
  static const Color orangeLight20 = Color(0xffFFC6B2);
  static const Color orangeLight30 = Color(0xffFFD9CC);
  static const Color orangeLight40 = Color(0xffFFECE5);
  static const Color orangePrimaryVariant = Color(0xffFF4100);

  // --- Reds & Dark Burgundy (Originally misnamed as black) ---
  static const Color redLight60 = Color(0xffE52800);
  static const Color redMedium80 = Color(0xffB20000);
  static const Color redDark90 = Color(0xff990000);
  static const Color maroon100 = Color(0xff800000);
  static const Color darkMaroon70 = Color(0xff660000);
  static const Color deepBurgundy80 = Color(0xff4D0000);
  static const Color bloodRed90 = Color(0xff330000);
  static const Color veryDarkRed100 = Color(0xff1A0000);

  // --- Status Colors ---
  static const Color success = Color(0xFF0CB258);
  static const Color error = Color(0xFFCC1010);
  static const Color surfaceOverlayLow = Color(0x1A242424);
  static const Color transparentColor=Colors.transparent;
}
