import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
        dialogBackgroundColor: AppColors.backgroundColor,
        primaryColor: AppColors.primaryColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          surface: AppColors.containersBgColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: 80,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.gray,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: AppStyles.w700(14),
          unselectedLabelStyle: AppStyles.w400(14),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(AppColors.primaryColor),
            textStyle: MaterialStateProperty.all(AppStyles.w700(14)),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: AppStyles.w400(16),
          bodyMedium: AppStyles.w400(14),
          bodySmall: AppStyles.w400(12),
          displayLarge: AppStyles.w700(32),
          displayMedium: AppStyles.w700(24),
          displaySmall: AppStyles.w700(20),
          headlineLarge: AppStyles.w700(18),
          headlineMedium: AppStyles.w700(16),
          headlineSmall: AppStyles.w700(14),
          labelLarge: AppStyles.w400(16),
          labelMedium: AppStyles.w400(14),
          labelSmall: AppStyles.w400(12),
          titleLarge: AppStyles.w700(18),
          titleMedium: AppStyles.w700(16),
          titleSmall: AppStyles.w700(14),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xfff6f6f9),
          filled: true,
          isCollapsed: true,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      );

  static ThemeData get darkThemeData => ThemeData(
        dialogBackgroundColor: AppColors.darkBackgroundColor,
        primaryColor: AppColors.primaryDarkColor,
        scaffoldBackgroundColor: AppColors.darkBackgroundColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryDarkColor,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryDarkColor,
          surface: AppColors.darkContainersBgColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackgroundColor,
          toolbarHeight: 80,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: AppColors.darkContainersBgColor,
          filled: true,
          isCollapsed: true,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.primaryDarkColor,
          unselectedLabelColor: AppColors.gray,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: AppStyles.w700(14),
          unselectedLabelStyle: AppStyles.w400(14),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(AppColors.primaryDarkColor),
            textStyle: MaterialStateProperty.all(AppStyles.w700(14)),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: AppStyles.w400(16, Colors.white),
          bodyMedium: AppStyles.w400(14, Colors.white),
          bodySmall: AppStyles.w400(12, Colors.white),
          displayLarge: AppStyles.w700(32, Colors.white),
          displayMedium: AppStyles.w700(24, Colors.white),
          displaySmall: AppStyles.w700(20, Colors.white),
          headlineLarge: AppStyles.w700(18, Colors.white),
          headlineMedium: AppStyles.w700(16, Colors.white),
          headlineSmall: AppStyles.w700(14, Colors.white),
          labelLarge: AppStyles.w400(16, Colors.white),
          labelMedium: AppStyles.w400(14, Colors.white),
          labelSmall: AppStyles.w400(12, Colors.white),
          titleLarge: AppStyles.w700(18, Colors.white),
          titleMedium: AppStyles.w700(16, Colors.white),
          titleSmall: AppStyles.w700(14, Colors.white),
        ),
      );
}
