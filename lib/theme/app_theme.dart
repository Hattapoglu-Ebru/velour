import 'package:flutter/material.dart';

class AppColors {
  // Ana gradient renkleri
  static const Color gradientStart = Color(0xFFFF6B9D);  // canlı pembe
  static const Color gradientMid = Color(0xFFB44FE8);    // mor
  static const Color gradientEnd = Color(0xFF7B2FFF);    // derin mor

  // Accent renkler
  static const Color accentPink = Color(0xFFFF6B9D);
  static const Color accentPurple = Color(0xFFB44FE8);
  static const Color accentDeep = Color(0xFF7B2FFF);
  static const Color accentGold = Color(0xFFFFD700);

  // Arka plan renkleri
  static const Color bgLight = Color(0xFFFDF6FF);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgGrey = Color(0xFFF5F0FF);

  // Metin renkleri
  static const Color textDark = Color(0xFF1A0A2E);
  static const Color textMedium = Color(0xFF6B5B8A);
  static const Color textLight = Color(0xFFA89BC2);

  // Yeni & Bestseller badge renkleri
  static const Color badgeNew = Color(0xFF00C9A7);
  static const Color badgeBestseller = Color(0xFFFFAB00);

  static const LinearGradient mainGradient = LinearGradient(
    colors: [gradientStart, gradientMid, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFF6B9D), Color(0xFFB44FE8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softGradient = LinearGradient(
    colors: [Color(0xFFFFF0F8), Color(0xFFF0E8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.gradientMid,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.bgLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
    );
  }
}
