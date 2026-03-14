import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback? onTap;

  const ServiceCard({super.key, required this.service, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        // Modern soft shadow
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        // Subtle border to give it that "premium" feel
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Specialty Badge (Adorable pill shape)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  service.specialty.toUpperCase(),
                  style: AppStyles.font12PrimaryBold.copyWith(
                    letterSpacing: 1.1,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              // Price Tag
              Text(
                "\$${service.price.toStringAsFixed(0)}",
                style: AppStyles.font18DarkBlueBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Service Title
          Text(service.title, style: AppStyles.font20DarkBlueBold),
          SizedBox(height: 8.h),
          // Description
          Text(
            service.description,
            style: AppStyles.font14GrayRegular.copyWith(
              height: 1.5, // Better readability
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.h),
          // Bottom Interaction Bar
          Row(
            children: [
              Text(
                "View Details",
                style: AppStyles.font14DarkBlueMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16.sp,
                color: AppColors.primary,
              ),
              const Spacer(),
              // Adorable "Book Now" Button
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                ),
                child: const Text("Book"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
