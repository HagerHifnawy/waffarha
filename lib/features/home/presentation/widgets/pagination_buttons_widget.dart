import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waffarha/features/home/cubit/home_cubit.dart';
import '../../../../core/theme/text_styles.dart';

class PaginationButtonsWidget extends StatelessWidget {
  const PaginationButtonsWidget(
      {super.key, required this.currentPage, required this.totalPages});
  final int currentPage, totalPages;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<HomeCubit>().changePage(false);
          },
          child: Text(
            'Previous',
            style: rubikMedium.copyWith(fontSize: 16.sp),
          ),
        ),
        20.horizontalSpace,
        Text(
          'Page ${currentPage + 1} of $totalPages',
          style: rubikMedium.copyWith(fontSize: 14.sp),
        ),
        20.horizontalSpace,
        ElevatedButton(
          onPressed: currentPage < totalPages - 1
              ? () {
                  context.read<HomeCubit>().changePage(true);
                }
              : null,
          child: Text(
            'Next',
            style: rubikMedium.copyWith(fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
