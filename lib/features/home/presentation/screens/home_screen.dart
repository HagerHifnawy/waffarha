import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waffarha/core/shared_widgets/custom_app_bar.dart';
import 'package:waffarha/core/theme/text_styles.dart';
import 'package:waffarha/features/home/cubit/home_cubit.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/pagination_buttons_widget.dart';
import '../widgets/photo_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Waffarha', canBack: false,actions: [
        IconButton(
          icon: Icon(Icons.filter_list,color: AppColors.secondaryColor,size: 40.r,),
          onPressed: () => context.read<HomeCubit>().showFilterBottomSheet(context),
        ),
        IconButton(
          icon:  Icon(Icons.sort,color: AppColors.secondaryColor,size: 40.r,),
          onPressed: () => context.read<HomeCubit>().showSortBottomSheet(context),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Photo details:',
                style: rubikBold.copyWith(
                    fontSize: 22.sp, decoration: TextDecoration.underline),
              ),
              20.verticalSpace,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final homeList = context.read<HomeCubit>().filteredModel ?? [];
                  final currentPage = context.read<HomeCubit>().currentPage;
                  final itemsPerPage = context.read<HomeCubit>().itemsPerPage;
                  final totalPages = (homeList.length / itemsPerPage).ceil();
                  final startIndex = currentPage * itemsPerPage;
                  final endIndex = (startIndex + itemsPerPage > homeList.length)
                      ? homeList.length
                      : startIndex + itemsPerPage;
                  final currentItems = homeList.sublist(startIndex, endIndex);
                  return Column(
                    children: [
                      PhotoListWidget(
                        currentItems: currentItems,
                      ),
                      20.verticalSpace,
                      PaginationButtonsWidget(
                        currentPage: currentPage,
                        totalPages: totalPages,
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
