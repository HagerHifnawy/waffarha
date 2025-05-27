import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waffarha/core/theme/colors.dart';
import 'package:waffarha/core/theme/text_styles.dart';

final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      scrolledUnderElevation: 0,
      titleTextStyle: rubikRegular.copyWith(color: AppColors.primaryColor),
      iconTheme:  IconThemeData(
        color: AppColors.primaryColor,
        size: 20.sp
      ),
      actionsIconTheme:  IconThemeData(
        color: AppColors.primaryColor,
                size: 20.sp
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
    ));
