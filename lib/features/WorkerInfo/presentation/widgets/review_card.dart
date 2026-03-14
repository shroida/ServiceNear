import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final RatingEntity review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: AppColors.scaffoldBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: .1),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    review.customerId.substring(0, 2).toUpperCase(),
                    style: AppStyles.font14BlueSemiBold,
                  ),
                ),

                SizedBox(width: 12.w),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16.sp,
                        color: AppColors.warning,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: AppStyles.font13BlueSemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),

            if (review.review.isNotEmpty)
              Expanded(
                child: Text(
                  review.review,
                  style: AppStyles.font14DarkRegular.copyWith(
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().format(review.createdAt),
                  style: AppStyles.font12GrayMedium,
                ),

                Row(
                  children: List.generate(
                    review.rating.round(),
                    (index) => Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Icon(
                        Icons.star,
                        size: 12.sp,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
