import 'package:flutter/material.dart';
import 'package:taskati/core/constants/asset_fonts.dart';
import 'package:taskati/core/utils/colors.dart';

class AppThemes{
  static ThemeData lightTheme =ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AssetFonts.poppins,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor,
    onSurface: AppColors.darkBackground
    ),
    dividerTheme:const DividerThemeData(
        color: AppColors.primaryColor, thickness: 1),
    appBarTheme:  const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: AssetFonts.poppins,
          fontWeight: FontWeight.w500),
    ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(
              color: AppColors.greyColor,
              fontFamily: AssetFonts.poppins,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.blueColor),
                borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.blueColor),
                borderRadius: BorderRadius.circular(10))));
  static ThemeData darkTheme =ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: AssetFonts.poppins,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        onSurface: AppColors.whiteColor
      ),
      dividerTheme:const DividerThemeData(
          color: AppColors.primaryColor, thickness: 1),
      appBarTheme:  const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontFamily: AssetFonts.poppins,
            fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            color: AppColors.greyColor,
            fontFamily: AssetFonts.poppins,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blueColor),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blueColor),
              borderRadius: BorderRadius.circular(10))));

}