import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waffarha/core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../data/models/home_model.dart';

class PhotoListWidget extends StatelessWidget {
  const PhotoListWidget({super.key, required this.currentItems});
final List<HomeModel> currentItems;
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentItems.length,
      separatorBuilder: (context, index) => 30.verticalSpace,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.r))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15.w, vertical: 15.h),
          child: Row(
            children: [
              SizedBox(
                height: 60.h,
                width: 60.w,
                child: Image.network(
                  currentItems[index].thumbnailUrl ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentItems[index].title ?? "",
                      style: rubikMedium.copyWith(
                          fontSize: 18.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Text(
                      'Album Id: ${currentItems[index].albumId}',
                      style: rubikRegular.copyWith(
                          fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
