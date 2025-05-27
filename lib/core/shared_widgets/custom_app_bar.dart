import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waffarha/core/theme/text_styles.dart';
import '../../core/theme/colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.title,
    this.canBack= true,
    this.actions
  });

  String title;
  bool canBack ;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      leading: canBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.secondaryColor),
              onPressed: () => Navigator.of(context).pop(),
            )
          : const SizedBox(),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: rubikMedium.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 20.sp,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12.r),
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
