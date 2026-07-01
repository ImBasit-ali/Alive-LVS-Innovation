import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'Alive';
  static const String appTagline = 'Sign in to continue your live streaming journey.';
  static const String appLogoText = 'Alive';

  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';

  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration logoAnimDuration = Duration(milliseconds: 1000);
  static const Duration textAnimDuration = Duration(milliseconds: 800);
  static const Duration shimmerAnimDuration = Duration(milliseconds: 1500);
  static const Duration textAnimDelay = Duration(milliseconds: 500);

  static const double logoSize = 100.0;
  static const double logoBorderRadius = 24.0;
  static const double cardBorderRadius = 14.0;
  static const double buttonBorderRadius = 25.0; // Pill shaped buttons

  // Sign In / Sign Up
  static const String googleSignInText = 'Continue with Google';
}

class AppColors {
  AppColors._();

  // App Brand Colors
  static const Color primary = Color(0xFF00A651); // Vibrant green
  static const Color secondary = Color(0xFF8DC63F); // Lime/light green
  static const Color error = Color(0xFFFF3B30);

  // Background and Surfaces
  static const Color background = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFF2F2F7);
  static const Color border = Color(0xFFE5E5EA);

  // Texts
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textLight = Color(0xFFD1D1D6);
  static const Color textLink = Color(0xFF00C22B);
  static const Color textDark = Color(0xFF1F1F1F);

  // Social Colors
  static const Color facebookBlue = Color(0xFF1877F2);
  
  // Google Brand Colors
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleRed = Color(0xFFEA4335);

  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8DC63F), // Lime Green
      Color(0xFF00A651), // Vibrant Green
    ],
  );

  static const LinearGradient bottomWaveGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF00A651),
      Color(0xFF8DC63F),
    ],
  );
}
