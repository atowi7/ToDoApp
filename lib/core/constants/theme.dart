import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/colors.dart';

ThemeData arabicTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: 'Cairo',
    ),
    iconTheme: IconThemeData(color: AppColor.primaryColor),
    backgroundColor: AppColor.secondaryColor,
    elevation: 0,
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColor.thirdColor,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.thirdColor,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.thirdColor,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 24,
      color: AppColor.forthColor,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 20,
      color: AppColor.forthColor,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 18,
      color: AppColor.forthColor,
    ),
  ),
);
ThemeData englishTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: 'Cairo',
    ),
    iconTheme: IconThemeData(color: AppColor.primaryColor),
    backgroundColor: AppColor.secondaryColor,
    elevation: 0,
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColor.thirdColor,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.thirdColor,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.sixthColor,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 24,
      color: AppColor.forthColor,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
      color: AppColor.forthColor,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18,
      color: AppColor.forthColor,
    ),
  ),
);
