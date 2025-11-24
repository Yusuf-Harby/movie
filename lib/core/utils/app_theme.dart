import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_colors.dart';

abstract class AppTheme {
  static ThemeData showDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: AppColors.primary,
      primaryColor: AppColors.selected,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.selected,
        onPrimary: AppColors.white,
        secondary: AppColors.gray,
        onSecondary: AppColors.white,
        surface: AppColors.primary,
        onSurface: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      textTheme: const TextTheme(
        
        displayLarge: TextStyle(
          color: AppColors.white,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          height: 1.2,
        ),
        displayMedium: TextStyle(
          color: AppColors.white,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          height: 1.2,
        ),
        displaySmall: TextStyle(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          height: 1.3,
        ),
        // Headline styles - for section titles
        headlineLarge: TextStyle(
          color: AppColors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          height: 1.3,
        ),
        titleLarge: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          height: 1.4,
        ),
        titleMedium: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          height: 1.4,
        ),
        titleSmall: TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto',
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto',
          height: 1.5,
        ),
        bodySmall: TextStyle(
          color: AppColors.gray,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto',
          height: 1.4,
        ),
        labelLarge: TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          height: 1.4,
        ),
        labelMedium: TextStyle(
          color: AppColors.gray,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          height: 1.4,
        ),
        labelSmall: TextStyle(
          color: AppColors.gray,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          height: 1.3,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.selected,
        unselectedItemColor: AppColors.gray,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.primary,
        hintStyle: const TextStyle(
          color: AppColors.gray,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
        labelStyle: const TextStyle(
          color: AppColors.gray,
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.selected),
        ),
      ),
    );
  }
}
