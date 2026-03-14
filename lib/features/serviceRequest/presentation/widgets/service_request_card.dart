import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';

class ServiceRequestCard extends StatelessWidget {
  final ServiceRequest request;
  final VoidCallback? onTap;

  const ServiceRequestCard({super.key, required this.request, this.onTap});

  Color _statusColor() {
    switch (request.status) {
      case "pending":
        return AppColors.warning;
      case "accepted":
        return AppColors.success;
      case "cancelled":
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.build_circle_outlined,
                    color: AppColors.primary,
                    size: 24.sp,
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Text(
                    request.title,
                    style: AppStyles.font14DarkRegular.copyWith(
                      fontSize: 18.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                /// STATUS BADGE
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor().withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    request.status.toUpperCase(),
                    style: AppStyles.font12BlueRegular.copyWith(
                      color: _statusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// DESCRIPTION
            Text(
              request.description,
              style: AppStyles.font14GrayRegular,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 14.h),

            /// LOCATION + PRICE
            Row(
              children: [
                if (request.location != null) ...[
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.sp,
                    color: AppColors.textHint,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      request.location!,
                      style: AppStyles.font13GrayRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],

                // if (request.price != null) ...[
                //   SizedBox(width: 10.w),
                //   Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 10.w,
                //       vertical: 4.h,
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.primary.withValues(alpha: .08),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Text(
                //       "\$${request.price}",
                //       style: AppStyles.font13BlueSemiBold,
                //     ),
                //   ),
                // ],
              ],
            ),

            SizedBox(height: 14.h),

            /// DATE
            Row(
              children: [
                Icon(Icons.schedule, size: 16.sp, color: AppColors.textHint),
                SizedBox(width: 6.w),
                Text(
                  "${request.createdAt.day}/${request.createdAt.month}/${request.createdAt.year}",
                  style: AppStyles.font12GrayRegular,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
