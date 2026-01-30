import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class WorkerCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String? specialist;

  const WorkerCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.specialist,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: 190.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (_, _, _) => Container(
                  height: 80.h,
                  color: AppColors.divider,
                  child: const Icon(Icons.person, size: 36),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            Text(
              name,
              style: AppStyles.font14DarkBlueBold,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 4.h),
            Text(
              specialist!,
              style: AppStyles.font12GrayRegular,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
