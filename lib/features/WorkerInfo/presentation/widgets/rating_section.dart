import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';

class RatingSection extends StatelessWidget {
  final double rating; // e.g. 4.5
  final int reviewsCount; // e.g. 120

  const RatingSection({
    super.key,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStars(rating),
          SizedBox(width: 12.w),
          Text(
            "$rating ($reviewsCount Reviews)",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (rating >= i) {
        stars.add(const Icon(Icons.star, color: AppColors.primary, size: 20));
      } else if (rating > i - 1 && rating < i) {
        stars.add(
          const Icon(Icons.star_half, color: AppColors.primary, size: 20),
        );
      } else {
        stars.add(
          const Icon(Icons.star_border, color: AppColors.primary, size: 20),
        );
      }
    }
    return Row(children: stars);
  }
}
