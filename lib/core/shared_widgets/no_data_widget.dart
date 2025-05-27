import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waffarha/core/theme/colors.dart';
import '../theme/text_styles.dart';

class NoDataWidget extends StatelessWidget {
  final String noDataText;
  const NoDataWidget({super.key, required this.noDataText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(noDataText,style: rubikRegular.copyWith(color: AppColors.secondaryColor,fontSize: 30.sp),)
      ],
    );
  }
}

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppColors.forthColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
            ],
          ),
        );
  }
}
